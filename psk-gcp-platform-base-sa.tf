resource "google_service_account" "psk_base" {
  count = var.provision_state_resources ? 1 : 0

  project      = local.state_project_id
  account_id   = "psk-gcp-platform-base-sa"
  display_name = "PSK GCP Platform Base Service Account"
  description  = "Service Account that can only assume other service account roles"
}

resource "google_service_account_iam_binding" "admin-account-iam" {
  count = var.provision_state_resources ? 1 : 0

  service_account_id = google_service_account.psk_base[0].name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principal://iam.googleapis.com/${google_iam_workload_identity_pool.workload_identity_pool[0].name}/subject/${var.circleci_org_id}",
  ]
}
