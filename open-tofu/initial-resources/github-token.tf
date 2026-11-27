resource "github_actions_secret" "arsdehnel_github_token" {
  for_each    = var.managed_repos
  repository  = each.value
  secret_name = "ARSDEHNEL_GITHUB_TOKEN"
  value       = var.github_token
}
