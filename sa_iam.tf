resource "google_project_iam_custom_role" "EMPCIAMProfilesRole" {
  role_id     = "EMPCIAMProfilesRole"
  title       = "EMPC IAM PRofiles Role"
  description = "Role used by terraform to manage IAM"
  permissions = [
    "iam.roles.create",
    "iam.roles.delete",
    "iam.serviceAccounts.create",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.setIamPolicy",
    "resourcemanager.projects.getIamPolicy",
    "resourcemanager.projects.setIamPolicy",
    "serviceusage.services.enable",
    "serviceusage.services.disable",
    ]
}

resource "google_service_account" "iam_profiles" {
  account_id   = "empc-iam-profiles-sa"
  display_name = "Service Account to manage IAM profiles"
}

resource "google_project_iam_member" "iam_profiles" {
  for_each = toset([
    "projects/${var.gcp_project_id}/roles/EMPCIAMProfilesRole",
    "projects/${var.gcp_project_id}/roles/EMPCTerraformBaseRole",
  ])
  role = each.key
  project = var.gcp_project_id
  member  = "serviceAccount:${google_service_account.iam_profiles.email}"

  depends_on = [ 
    google_project_iam_custom_role.EMPCIAMProfilesRole,
    google_project_iam_custom_role.EMPCTerraformRole 
  ]
}

resource "google_service_account_iam_binding" "iam_profiles" {
  service_account_id = google_service_account.iam_profiles.name
  role               = "roles/iam.serviceAccountTokenCreator"

  members = [
    "serviceAccount:${google_service_account.sa.email}"
  ]
}

