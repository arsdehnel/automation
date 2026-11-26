# @arsdehnel/cli

Internal CLI for the arsdehnel automation platform.

## Setup

```bash
pnpm install
pnpm build
```

The `arsd` binary is available at `./dist/cli.js` after building, or via `pnpm dev` for local development without a build step.

## Commands

### `arsd tofu view-state`

Interactively browse OpenTofu remote state stored in Cloudflare R2.

Discovers state files for the current repo (derived from `git remote get-url origin`) and lets you pick a state file, then a resource, and dumps the resource attributes to stdout.

**Required env vars:**

| Variable              | Description           | Maps to GitHub secret |
| --------------------- | --------------------- | --------------------- |
| `CF_R2_ACCESS_KEY_ID` | R2 access key ID      | `CF_R2_ACCESS_KEY_ID` |
| `CF_R2_SECRET_KEY`    | R2 secret access key  | `CF_R2_SECRET_KEY`    |
| `CF_ACCOUNT_ID`       | Cloudflare account ID | `CF_ACCOUNT_ID`       |

These are the same credentials used by CI workflows. You can find the values in the GitHub org secrets or in your Cloudflare dashboard under R2 → Manage R2 API tokens.

The R2 token needs **Workers R2 Storage Bucket Item Read** permission on the `arsdehnel-opentofu-remote-state` bucket.

**Options:**

| Flag           | Description                                           |
| -------------- | ----------------------------------------------------- |
| `--app <name>` | Override the app name (defaults to current repo name) |
| `--verbose`    | Show debug output                                     |

**Example:**

```bash
export CF_R2_ACCESS_KEY_ID=...
export CF_R2_SECRET_KEY=...
export CF_ACCOUNT_ID=...

arsd tofu view-state
```
