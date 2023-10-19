#!/usr/bin/env bash
echo "Store workload itentity pool values"
exec 1> /dev/null
ITEM_NAME=psk-platform-gcp-workload-identity-config

# Create the 1Password item if it doesn't exist
if ! op item get $ITEM_NAME ;
then
cat <<EOF | op item create --vault empc-lab --account twdps -
{
    "title": "$ITEM_NAME",
    "category": "API_CREDENTIAL",
    "fields": []
}
EOF
fi

# Retrieve the workload identity config values
terraform init
WIP_ID=$(terraform output workload_identity_configuration_id)
SERVICE_ACCOUNT_EMAIL=$(terraform output service_account_email)

# write the workload identity config values to the secret store
op item edit "$ITEM_NAME" --account="twdps" --vault="empc-lab" "workload-identitty-pool-id[text]=$WIP_ID" "service-account-email[text]=$SERVICE_ACCOUNT_EMAIL"
