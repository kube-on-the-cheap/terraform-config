output "oci_etcd_bucket_s3_credentials" {
  description = "Credentials to access OCI buckets via S3 Compatibility"
  sensitive   = true
  value       = lookup(module.k3s_object_storage, "s3_credentials", null)
}

# output "k3s_s3_etcd_secret_id" {
#   description = "The Secret ID of the SECRET_KEY to access S3 ETCD backup bucket"
#   value       = oci_vault_secret.s3_secret_key.id
# }
