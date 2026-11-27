#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if [[ ! -f "local.auto.tfvars" ]]; then
  echo "Error: local.auto.tfvars not found."
  echo "Create it with cloudflare_account_id, cloudflare_api_token, github_token, arsdehnel_github_token, and managed_repos before running this script."
  exit 1
fi

ACCOUNT_ID=$(grep -E 'cloudflare_account_id\s*=' local.auto.tfvars | sed 's/.*=\s*"\(.*\)"/\1/')
GITHUB_ORG="arsdehnel"
BUCKET_NAME="arsdehnel-opentofu-remote-state"

if [[ -z "$ACCOUNT_ID" ]]; then
  echo "Error: could not parse cloudflare_account_id from local.auto.tfvars"
  exit 1
fi

if [[ -z "${CF_TOKEN_ID:-}" ]]; then
  echo "Error: CF_TOKEN_ID environment variable is not set."
  echo "Find the token ID for the 'arsdehnel-cloudflare-token' account token in the Cloudflare dashboard (Account → Account API Tokens)."
  exit 1
fi

tofu init
tofu import cloudflare_r2_bucket.opentofu_remote_state "${ACCOUNT_ID}/${BUCKET_NAME}"
tofu import cloudflare_account_token.cf_account_token "${CF_TOKEN_ID}"
# All secrets are managed via for_each over managed_repos.
# Import one line per repo per secret. Example for the default repos:
# tofu import 'github_actions_secret.r2_access_key_id["automation"]'      "${GITHUB_ORG}/automation/CF_R2_ACCESS_KEY_ID"
# tofu import 'github_actions_secret.r2_secret_key["automation"]'         "${GITHUB_ORG}/automation/CF_R2_SECRET_KEY"
# tofu import 'github_actions_secret.cloudflare_account_id["automation"]' "${GITHUB_ORG}/automation/CF_ACCOUNT_ID"
# tofu import 'github_actions_secret.cloudflare_token["automation"]'      "${GITHUB_ORG}/automation/CF_TOKEN"
# tofu import 'github_actions_secret.arsdehnel_github_token["automation"]' "${GITHUB_ORG}/automation/ARSDEHNEL_GITHUB_TOKEN"
