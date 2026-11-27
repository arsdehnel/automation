variable "cloudflare_api_token" {
  description = "API token with enough permissions for the resources being defined"
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "The account ID into which these resources should be provisioned"
  type        = string
}

variable "github_token" {
  description = "Classic PAT with admin:org scope — used by the Terraform provider itself"
  type        = string
  sensitive   = true
}

variable "managed_repos" {
  description = "Repos that receive ARSDEHNEL_GITHUB_TOKEN. Add a repo here when you create it."
  type        = set(string)
  default     = ["automation", "pov-builders"]
}
