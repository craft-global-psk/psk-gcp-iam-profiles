#!/usr/bin/env bash
OP_SECRET=psk-platform-gcp-workload-identity-config
WIP_ID=$(op item get $OP_SECRET --vault empc-lab --fields label=workload-identity-pool-id)
SERVICE_ACCOUNT_EMAIL=$(op item get $OP_SECRET --vault empc-lab --fields label=service-account-email)

OIDC_TOKEN_PATH=$1
GCP_CRED_FILE_PATH=$2

# Store OIDC token in temp file
echo $CIRCLE_OIDC_TOKEN > $OIDC_TOKEN_PATH

# Create a credential configuration for the generated OIDC ID Token
gcloud iam workload-identity-pools create-cred-config \
    $WIP_ID \
    --output-file=$GCP_CRED_FILE_PATH \
    --service-account=$SERVICE_ACCOUNT_EMAIL \
    --credential-source-file=$OIDC_TOKEN_PATH

# Configure gcloud to leverage the generated credential configuration
gcloud auth login --brief --cred-file $GCP_CRED_FILE_PATH
# Configure ADC
echo "export GOOGLE_APPLICATION_CREDENTIALS='$GCP_CRED_FILE_PATH'" | tee -a "$BASH_ENV"

# Verify authentication
gcloud iam service-accounts get-iam-policy "${SERVICE_ACCOUNT_EMAIL}"
