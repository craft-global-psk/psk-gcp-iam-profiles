#!/usr/bin/env bash
export ENVIRONMENT=$1

gcloud auth login --cred-file=./gcp-creds.json &>/dev/null
gcloud config set auth/impersonate_service_account empc-iam-profiles-sa@${GCP_PROJECT_ID}.iam.gserviceaccount.com &>/dev/null

inspec exec tests/iam-roles -t gcp:// --input gcp_project_id=${GCP_PROJECT_ID}  
inspec exec tests/enabled-apis -t gcp:// --input gcp_project_id=${GCP_PROJECT_ID}

gcloud config unset auth/impersonate_service_account &>/dev/null
gcloud auth revoke empc-${ENVIRONMENT}-service-account@${GCP_PROJECT_ID}.iam.gserviceaccount.com &>/dev/null