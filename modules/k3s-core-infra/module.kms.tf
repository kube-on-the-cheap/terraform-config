# Variables
variable "k3s_oci_keys" {
  type        = map(string)
  description = "A map of key names and their types to create"
  validation {
    condition     = length([for name, type in var.k3s_oci_keys : name if contains(["aes", "rsa", "ecdsa"], type)]) > 0
    error_message = "You must specify at least one key to provision, and the type must be one of \"aes\", \"rsa\" or \"ecdsa\"."
  }
}

# Locals
locals {
  oci_vault_name = "K3s"
}

# Resources
module "k3s_oci_kms" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-kms?ref=feat/network-module"

  oci_compartment_id = oci_identity_compartment.k3s_compartment.id
  oci_vault_name     = local.oci_vault_name
  oci_keys           = var.k3s_oci_keys # gitleaks:allow
}

# Outputs
output "oci_kms_vault" {
  value       = module.k3s_oci_kms.vault
  description = "The generated Vault ID"
}

output "oci_kms_master_encryption_keys" {
  value       = module.k3s_oci_kms.master_encryption_keys
  description = "The generated master encryption keys (MEKs)"
}
