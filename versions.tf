terraform {
  required_version = "~> 1.1"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.75.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  impersonate_service_account = "empc-iam-profiles-sa@${var.gcp_project_id}.iam.gserviceaccount.com"
}
