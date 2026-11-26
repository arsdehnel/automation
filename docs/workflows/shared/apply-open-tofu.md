# apply-open-tofu.yaml

## Check name

`apply-open-tofu`

Runs `tofu init`, `tofu plan`, and `tofu apply` against a single OpenTofu configuration directory, using the shared Cloudflare R2 bucket as the remote backend for state storage.

The plan is saved and passed directly to apply, so the apply step executes exactly what was planned. This also sets up a clean split point for adding an approval gate between plan and apply in the future — that would require splitting this into two jobs with artifact upload/download, but no changes to the caller workflow.

The backend configuration is fully managed by the workflow — calling repos do not declare a backend block. State is stored at `<app_name>/<state_type>/<state_name>/terraform.tfstate`.

The `state_name` input is also used as the GitHub Actions environment for the job. If the named environment doesn't exist it will be created automatically with no protection rules.

## Inputs

| Input               | Required | Description                                                                                                                   |
| ------------------- | -------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `app_name`          | Yes      | Application name — first segment of the state key                                                                             |
| `state_type`        | Yes      | State category — second segment of the state key (e.g. `github-config`, `app-deployment`)                                     |
| `state_name`        | Yes      | Instance within the category — third segment of the state key and the GitHub Actions environment (e.g. `setup`, `production`) |
| `working_directory` | Yes      | Path to the OpenTofu root configuration within the calling repo                                                               |

## Secrets

| Secret                | Provisioned by                |
| --------------------- | ----------------------------- |
| `CF_R2_ACCESS_KEY_ID` | `open-tofu/initial-resources` |
| `CF_R2_SECRET_KEY`    | `open-tofu/initial-resources` |
| `CF_ACCOUNT_ID`       | `open-tofu/initial-resources` |

These are read directly from organization secrets — callers do not need to map them.

## Terraform variables

The workflow automatically exports `PLATFORM_GH_TOKEN` as `TF_VAR_platform_gh_token`, making it available to OpenTofu configurations as an input variable without any caller configuration.

GitHub Actions does not support dynamic secret lookup at runtime — `${{ secrets[variable] }}` is not valid syntax — so any additional secrets needed as Terraform variables must be mapped explicitly.

## Permissions

| Permission | Level  |
| ---------- | ------ |
| `contents` | `read` |
