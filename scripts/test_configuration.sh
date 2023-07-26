#!/usr/bin/env bash
export ENVIRONMENT=$1

gcloud auth login --cred-file=./gcp-creds.json
gcloud config set auth/impersonate_service_account empc-iam-profiles-sa@${GCP_PROJECT_ID}.iam.gserviceaccount.com

inspec exec tests/lab-gcp-iam-profiles -t gcp:// --input gcp_project_id=${GCP_PROJECT_ID}
