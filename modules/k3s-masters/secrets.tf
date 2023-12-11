# Variables
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

# Locals
locals {
  secret_tokens = toset(["agent-token", "token"])
}

# Resources
resource "random_password" "tokens" {
  for_each = local.secret_tokens

  length           = startswith(each.value, "agent") ? 16 : 32
  override_special = startswith(each.value, "agent") ? "#$%*-_+" : null
}

resource "oci_vault_secret" "tokens" {
  for_each = local.secret_tokens

  compartment_id = var.k3s_compartment_id
  vault_id       = var.oci_kms_vault_id
  secret_name    = each.value
  description    = format("%s used by K3s", each.value)
  key_id         = var.oci_kms_secrets_master_encryption_key_id
  secret_content {
    # We don't really have a choice, do we?
    content_type = "BASE64"
    content      = base64encode(random_password.tokens[each.value].result)
  }
  lifecycle {
    create_before_destroy = false
  }
}

resource "oci_vault_secret" "etcd_s3_secret_key" {
  compartment_id = var.k3s_compartment_id
  vault_id       = var.oci_kms_vault_id
  secret_name    = "etcd-s3-secret-key"
  description    = "Secret Key to access the k3s_etcd_backup bucket"
  key_id         = var.oci_kms_secrets_master_encryption_key_id
  secret_content {
    # We don't really have a choice, do we?
    content_type = "BASE64"
    content      = base64encode(var.oci_etcd_bucket_s3_credentials["SECRET_KEY"])
  }
}
