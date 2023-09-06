resource "google_project_iam_custom_role" "EMPCTerraformRole" {
  role_id     = "EMPCTerraformBaseRole"
  title       = "EMPC Terraform Base Role"
  description = "Role used by terraform job executions"
  permissions = [
    "resourcemanager.projects.get",
    "serviceusage.quotas.get",
    "serviceusage.services.get",
    "serviceusage.services.list",
    "iam.roles.get",
    "iam.serviceAccounts.getIamPolicy"
  ]
}

resource "google_service_account" "sa" {
  account_id   = "empc-base-service-account"
  display_name = "EMPC Base Service Account"
  description  = "Service Account that can only assume other service account roles"
}

resource "google_project_iam_member" "project" {
  for_each = toset([
    "roles/iam.serviceAccountCreator",
    "projects/${var.gcp_project_id}/roles/EMPCTerraformBaseRole",
  ])
  role    = each.key
  project = var.gcp_project_id
  member  = "serviceAccount:${google_service_account.sa.email}"

  depends_on = [google_project_iam_custom_role.EMPCTerraformRole]
}
