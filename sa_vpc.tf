resource "google_service_account" "vpc" {
  account_id   = "empc-vpc-sa"
  display_name = "Service Account to manage VPCs and subnets"
}

module "vpc-role" {
  source = "terraform-google-modules/iam/google//modules/custom_role_iam"

  target_level         = "project"
  target_id            = var.gcp_project_id
  role_id              = "EMPCVPCRole"
  title                = "EMPC VPC Role"
  description          = "Role used by terraform to manage VPCs and Subnets"
  base_roles           = ["roles/compute.networkAdmin", "roles/compute.xpnAdmin", "projects/${var.gcp_project_id}/roles/EMPCTerraformBaseRole"]
  permissions          = []
  excluded_permissions = [
    "networksecurity.firewallEndpoints.create",
    "networksecurity.firewallEndpoints.delete",
    "networksecurity.firewallEndpoints.get",
    "networksecurity.firewallEndpoints.list",
    "networksecurity.firewallEndpoints.update",
    "networksecurity.firewallEndpoints.use",
    "resourcemanager.projects.list"
  ]
  members              = ["serviceAccount:empc-vpc-sa@${var.gcp_project_id}.iam.gserviceaccount.com"]

  depends_on = [ google_service_account.vpc ]
}

resource "google_service_account_iam_binding" "vpc" {
  service_account_id = google_service_account.vpc.name
  role               = "roles/iam.serviceAccountTokenCreator"

  members = [
    "serviceAccount:${google_service_account.sa.email}"
  ]
}
