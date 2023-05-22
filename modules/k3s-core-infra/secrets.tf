# Variables

# Locals
locals {
  secret_tokens = var.k3s_setup_secrets ? toset(["agent-token", "token"]) : toset([])
}

# Resources
resource "random_password" "tokens" {
  for_each = local.secret_tokens

  length           = each.value == "agent-token" ? 16 : 32
  override_special = each.value == "agent-token" ? "#$%*-_+" : null
}

resource "oci_vault_secret" "tokens" {
  for_each = local.secret_tokens

  compartment_id = oci_identity_compartment.k3s_compartment.id
  vault_id       = one(values(module.k3s_oci_kms.vault))
  secret_name    = each.value
  description    = format("%s used by K3s", each.value)
  key_id         = module.k3s_oci_kms.master_encryption_keys["secrets"]
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
  count = var.k3s_setup_etcd_backup ? 1 : 0

  compartment_id = oci_identity_compartment.k3s_compartment.id
  vault_id       = one(values(module.k3s_oci_kms.vault))
  secret_name    = "etcd-s3-secret-key"
  description    = "Secret Key to access the k3s_etcd_backup bucket"
  key_id         = module.k3s_oci_kms.master_encryption_keys["secrets"]
  secret_content {
    # We don't really have a choice, do we?
    content_type = "BASE64"
    content      = base64encode(module.k3s_object_storage["k3s_etcd_backup"].s3_credentials["SECRET_KEY"])
  }
  lifecycle {
    create_before_destroy = false
  }
}

# Output
output "k3s_secrets_tags_masters" {
  description = "Defined Tags containing secret references to set for Master nodes"
  value = merge(
    {
      for name in local.secret_tokens : format("K3s-ClusterSecrets.%s", name) => oci_vault_secret.tokens[name].id
    },
    var.k3s_setup_etcd_backup ? { "K3s-ClusterSecrets.etcd-s3-secret-key" : one(oci_vault_secret.etcd_s3_secret_key.*.id) } : {} # gitleaks:allow
  )
}

# NOTE: in the workers, the "token" config entry is really the "agent-token"
output "k3s_secrets_tags_workers" {
  description = "Defined Tags containing secret references to set for Worker nodes"
  value = { for name in local.secret_tokens :
    "K3s-ClusterSecrets.token" => oci_vault_secret.tokens[name].id if name == "agent-token"
  }
}
