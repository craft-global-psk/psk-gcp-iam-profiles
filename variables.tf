variable "org_id" {
  type        = string
  description = "The org identifier, format is `organizations/<org_id>` "
}

variable "gcp_project_id" {
  type        = string
  description = "The project ID to host the network in"
}
