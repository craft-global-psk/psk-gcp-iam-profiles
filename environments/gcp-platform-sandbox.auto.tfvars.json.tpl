{
  "gcp_project_id"  : "{{ op://craft-infra/gcp-sandbox/gcp-project-id }}",
  "gcp_state_project_id" : "{{ op://craft-infra/gcp-state/gcp-project-id }}",
  "provision_state_resources" : "true",
  "create_folder" : "false",
  "create_project_structure" : "false",
  "circleci_org_id" : "{{ op://craft-infra/svc-circleci/organization-id }}",
  "workload_identity_pool_id" : "psk-platform-pool"
}
