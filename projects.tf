resource "random_id" "project" {
  count       = var.create_project_structure ? 1 : 0
  byte_length = 2
}

resource "google_folder" "engineering_platform" {
  count        = var.create_folder ? 1 : 0
  display_name = var.folder_name
  parent       = var.folder_parent

  lifecycle {
    precondition {
      condition     = (var.create_folder == true && var.folder_name != "" && var.folder_parent != "")
      error_message = "A folder name and parent must be specified to create a folder"
    }
  }
}

resource "google_project" "ep_project" {
  for_each = var.create_project_structure ? var.projects : {}

  project_id      = "${each.value.name}-${random_id.project[0].hex}"
  name            = each.value.name
  org_id          = can(each.value.org_id) ? each.value.org_id : null
  folder_id       = can(each.value.folder_id) ? each.value.folder_id : null
  billing_account = can(each.value.billing_account) ? each.value.billing_account : null

  skip_delete         = false
  auto_create_network = false

  depends_on = [google_folder.engineering_platform]
}

resource "google_project_iam_audit_config" "project_good_audit" {
  for_each = var.create_project_structure ? google_project.ep_project : {}

  project = trimprefix(each.value.id, "projects/")
  service = "allServices"
  audit_log_config {
    log_type = "ADMIN_READ"
  }
  audit_log_config {
    log_type = "DATA_READ"
  }
  audit_log_config {
    log_type = "DATA_WRITE"
  }
}
