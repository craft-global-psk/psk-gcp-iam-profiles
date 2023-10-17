variable "gcp_state_project_id" {
  type        = string
  description = "The project ID to of the State Account"
  default     = "lab-platform-state"
}

variable "gcp_project_id" {
  type        = string
  description = "The project ID to provision IAM resources in"
}
