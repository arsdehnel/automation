resource "github_actions_secret" "r2_access_key_id" {
  for_each    = var.managed_repos
  repository  = each.value
  secret_name = "CF_R2_ACCESS_KEY_ID"
  value       = cloudflare_account_token.cf_account_token.id
}

resource "github_actions_secret" "r2_secret_key" {
  for_each    = var.managed_repos
  repository  = each.value
  secret_name = "CF_R2_SECRET_KEY"
  value       = sha256(cloudflare_account_token.cf_account_token.value)
}

resource "github_actions_secret" "cloudflare_account_id" {
  for_each    = var.managed_repos
  repository  = each.value
  secret_name = "CF_ACCOUNT_ID"
  value       = var.cloudflare_account_id
}

resource "github_actions_secret" "cloudflare_token" {
  for_each    = var.managed_repos
  repository  = each.value
  secret_name = "CF_TOKEN"
  value       = cloudflare_account_token.cf_account_token.value
}
