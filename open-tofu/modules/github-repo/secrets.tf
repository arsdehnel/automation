resource "github_actions_organization_secret_repository" "cloudflare_token" {
  secret_name   = "CF_TOKEN"
  repository_id = github_repository.repo.repo_id
}
