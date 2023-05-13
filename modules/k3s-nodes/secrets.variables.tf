variable "oci_kms_vault_id" {
  type        = string
  description = "The Vault ID to store Agent and Token secrets"
}

variable "oci_kms_secrets_master_encryption_key_id" {
  type        = string
  description = "The MEK ID used to encrypt tokens"
}

variable "oci_etcd_bucket_s3_credentials" {
  type        = map(string)
  sensitive   = true
  description = "Credentials to access OCI buckets via S3 Compatibility"
}
