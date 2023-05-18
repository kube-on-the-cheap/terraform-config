output "oci_etcd_bucket_s3_credentials" {
  description = "Credentials to access OCI buckets via S3 Compatibility"
  sensitive   = true
  value       = lookup(module.k3s_object_storage, "s3_credentials", null)
}
