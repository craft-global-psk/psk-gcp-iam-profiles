variable "provision_state_resources" {
  type        = bool
  description = "Whether this should also provision base resources in the state account"
  default     = false
}

variable "gcp_state_project_id" {
  type        = string
  description = "The project ID to of the State Account"
}

variable "gcp_project_id" {
  type        = string
  description = "The project ID to provision IAM resources in"
}

variable "workload_identity_pool_id" {
  type        = string
  description = "The workload identity pool that will be used to authenticate CI orchestration"
  default     = "psk-engineering-platform"
}

variable "workload_identity_pool_provider_id" {
  type        = string
  description = "Identity Provider ID to use for the CI Orchestration integration"
  default     = "circleci-provider"
}

variable "circleci_org_id" {
  type        = string
  description = "The ID of the CircleCI organization that will be used to authenticate CI orchestration"
  default     = ""
}

variable "create_folder" {
  type        = bool
  description = "Should a folder be created for EP projects"
  default     = false
}

variable "folder_name" {
  type        = string
  description = "The name of the EP folder that will be used to store projects related to the EP"
  default     = ""
}

variable "folder_parent" {
  type        = string
  description = "The parent of the EP folder that will be used to store projects related to the EP"
  validation {
    condition     = (var.folder_parent == "" || can(regex("^(folders|organizations)/[0-9]+$", var.folder_parent)))
    error_message = "folder_parent must be of the form 'folders/{folderId} or 'organizations/{organizationId'}"
  }
  default = ""
}

variable "create_project_structure" {
  type        = bool
  description = "Whether to create the EP project structure for SDLC environments"
  default     = false
}

variable "projects" {
  type = map(object({
    name            = string
    org_id          = optional(string)
    folder_id       = optional(string)
    billing_account = optional(string)
  }))

  description = "A list of projects tpo be created that will be used by the EP"
  default     = {}

  validation {
    condition = alltrue([
      for p in var.projects :
      (can(p.org_id) && p.folder_id == null) ||
      (can(p.folder_id) && p.org_id == null) ||
      (p.org_id == null && p.folder_id == null)
    ])
    error_message = "Only 1 of 'org_id' and 'folder_id' can be specified for a project"
  }
}
