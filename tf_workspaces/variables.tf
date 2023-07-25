variable "workspace_prefix" {
  type        = string
  description = "Prefix to use for all workspace names"
}

variable "workspace_environments" {
  type        = list(string)
  description = "List of environment workspaces to be created"
}

variable "tfe_token" {
  type        = string
  sensitive   = true
  description = "API token used by TFE to create workspaces"
}
