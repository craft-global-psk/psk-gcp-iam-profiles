resource "google_project_service" "iam_credentials" {
  project                    = var.gcp_project_id
  service                    = "iamcredentials.googleapis.com"
  disable_dependent_services = true
}

//resource "google_project_service" "state_iam_credentials" {
//  count = var.is_state_account ? 1 : 0
//  project                    = var.gcp_state_project_id
//  service                    = "iamcredentials.googleapis.com"
//  disable_dependent_services = true
//}

resource "google_project_service" "iam" {
  project                    = var.gcp_project_id
  service                    = "iam.googleapis.com"
  disable_dependent_services = true
}

//resource "google_project_service" "state_iam" {
//  count = var.is_state_account ? 1 : 0
//  project                    = var.gcp_state_project_id
//  service                    = "iam.googleapis.com"
//  disable_dependent_services = true
//}

resource "google_project_service" "crm" {
  project                    = var.gcp_project_id
  service                    = "cloudresourcemanager.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "service_usage" {
  project                    = var.gcp_project_id
  service                    = "serviceusage.googleapis.com"
  disable_dependent_services = true
}

//resource "google_project_service" "compute" {
//  project                    = var.gcp_project_id
//  service                    = "compute.googleapis.com"
//  disable_dependent_services = true
//}
