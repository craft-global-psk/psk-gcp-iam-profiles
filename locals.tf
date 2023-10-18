locals {
  state_project_id = var.create_project_structure ? trimprefix(google_project.ep_project["state"].id, "projects/") : var.gcp_state_project_id
}
