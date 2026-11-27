resource "github_repository_environment" "environment" {
  environment = var.environment_name
  repository  = var.repo_name

  dynamic "reviewers" {
    for_each = var.environment_name == "integration" ? [] : [1]
    content {
      users = [data.github_user.reviewer.id]
    }
  }

  deployment_branch_policy {
    protected_branches     = false
    custom_branch_policies = true
  }
}
