resource "google_iam_workload_identity_pool" "workload_identity_pool" {
  count = var.provision_state_resources ? 1 : 0

  workload_identity_pool_id = var.workload_identity_pool_id
  display_name              = var.workload_identity_pool_id
  description               = "Workload Identity Pool for CI orchestration"
  project                   = local.state_project_id
}

resource "google_iam_workload_identity_pool_provider" "workload_identity_pool_provider" {
  count = var.provision_state_resources ? 1 : 0

  workload_identity_pool_id          = google_iam_workload_identity_pool.workload_identity_pool[0].workload_identity_pool_id
  workload_identity_pool_provider_id = var.workload_identity_pool_provider_id
  project                            = local.state_project_id
  attribute_mapping = {
    "google.subject"    = "assertion.sub"
    "attribute.aud"     = "assertion.aud"
    "attribute.project" = "assertion['oidc.circleci.com/project-id']"
  }
  oidc {
    allowed_audiences = [var.circleci_org_id]
    issuer_uri        = "https://oidc.circleci.com/org/${var.circleci_org_id}"
  }
}
