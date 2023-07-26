#!/usr/bin/env bash
export ENVIRONMENT=$1

gcloud auth login --cred-file=./gcp-creds.json -q &>/dev/null
gcloud config set auth/impersonate_service_account empc-iam-profiles-sa@${GCP_PROJECT_ID}.iam.gserviceaccount.com &>/dev/null

echo "Create new key..."
# Get and store the new key
gcloud iam service-accounts keys create --iam-account "empc-base-service-account@${GCP_PROJECT_ID}.iam.gserviceaccount.com" --project="${GCP_PROJECT_ID}" ./new-gcp-creds.json &>/dev/null

echo "Store new key"
cat new-gcp-creds.json | op document edit "gcp-${ENVIRONMENT}-creds.json" -

echo "Delete old key"
# Retrieve the ID for the old key
OLD_KEY_ID=$(cat gcp-creds.json | jq -r '.private_key_id')
# Delete the old key
gcloud iam service-accounts keys delete "$OLD_KEY_ID" --iam-account "empc-base-service-account@${GCP_PROJECT_ID}.iam.gserviceaccount.com" -q &>/dev/null

echo "Operation Complete"

#Unset impersonation (mostly for local testing and caches)
cat new-gcp-creds.json > gcp-creds.json
rm new-gcp-creds.json
gcloud config unset auth/impersonate_service_account &>/dev/null
