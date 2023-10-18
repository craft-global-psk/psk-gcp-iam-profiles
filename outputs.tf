output "workload_identity_configuration_id" {
  value = var.provision_state_resources ? "${google_iam_workload_identity_pool.workload_identity_pool[0].id}/providers/${google_iam_workload_identity_pool_provider.workload_identity_pool_provider[0].id}" : ""
}

output "service_account_email" {
  value = var.provision_state_resources ? google_service_account.psk_base[0].email : ""
}
