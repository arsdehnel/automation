resource "github_repository_ruleset" "semver_tags" {
  name        = "semver-tags"
  repository  = github_repository.repo.name
  target      = "tag"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~ALL"]
      exclude = []
    }
  }

  rules {
    deletion = true
  }
}
