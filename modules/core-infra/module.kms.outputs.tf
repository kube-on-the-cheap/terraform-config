output "oci_kms_vault_id" {
  value       = module.k3s_oci_kms.vault_id
  description = "The generated Vault ID"
}

output "oci_kms_master_encryption_keys_ids" {
  value       = module.k3s_oci_kms.master_encryption_keys_ids
  description = "The generated master encryption keys (MEKs)"
}
