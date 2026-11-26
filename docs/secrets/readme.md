# Secrets

Naming and usage conventions for GitHub Actions secrets across the arsdehnel automation platform.

## Org secrets

| Secret                | What it is                                                                                                                  |
| --------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| `CF_TOKEN`            | Cloudflare account token for deploying workers and managing Cloudflare infrastructure                                       |
| `CF_ACCOUNT_ID`       | Cloudflare account ID that all resources are provisioned into                                                               |
| `CF_R2_ACCESS_KEY_ID` | Cloudflare token ID, formatted as an S3 access key for authenticating to the remote state R2 bucket                         |
| `CF_R2_SECRET_KEY`    | `sha256` of the Cloudflare token value, formatted as an S3 secret key for the remote state R2 bucket                        |
| `PLATFORM_GH_TOKEN`   | Fine-grained GitHub PAT for managing GitHub org resources via OpenTofu — see [rotation procedure](./github-pat-rotation.md) |

The Cloudflare secrets are provisioned by `open-tofu/initial-resources`. `PLATFORM_GH_TOKEN` is rotated manually.

## Secrets mapping in workflows

Workflow authors map these to whatever env var name the consuming tool expects. For example, Wrangler reads `CLOUDFLARE_API_TOKEN`:

```yaml
env:
  CLOUDFLARE_API_TOKEN: ${{ secrets.CF_TOKEN }}
  CLOUDFLARE_ACCOUNT_ID: ${{ secrets.CF_ACCOUNT_ID }}
```

Most shared workflows in this repo handle secrets mapping internally. Callers use `secrets: inherit` and do not need to map secrets themselves.

## See also

- [Workflow secrets mapping](../workflows/readme.md#secrets) — how workflow authors map these to env vars
- [initial-resources](../../open-tofu/initial-resources/readme.md) — where Cloudflare secrets are provisioned
