#!/usr/bin/env bash
export NETWORK=$1
export ENV_PATH=./environments/$1

export TF_VAR_gcp_project_id=$(cat ${ENV_PATH}.auto.tfvars.json.tpl | jq -r .project_id)
export TF_VAR_org_id=$(cat ${ENV_PATH}.auto.tfvars.json.tpl | jq -r .org_id)


echo "PROJECT " $TF_VAR_gcp_project_id $TF_VAR_org_id
