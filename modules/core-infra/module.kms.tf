# Variables
variable "k3s_oci_keys" {
  type        = map(string)
  description = "A map of key names and their types to create"
  validation {
    condition     = length([for name, type in var.k3s_oci_keys : name if contains(["aes", "rsa", "ecdsa"], type)]) > 0
    error_message = "You must specify at least one key to provision, and the type must be one of \"aes\", \"rsa\" or \"ecdsa\"."
  }
}

variable "k3s_oci_vault_name" {
  type        = string
  description = "The OCI Vault name"
}

# Resources
module "k3s_oci_kms" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-kms?ref=v1.0.0"

  oci_compartment_id = module.oci_compartments[local.k3s_compartment_name].id
  oci_vault_name     = var.k3s_oci_vault_name
  oci_keys           = var.k3s_oci_keys # gitleaks:allow
}

# Outputs
output "oci_kms_vault_id" {
  value       = module.k3s_oci_kms.vault_id
  description = "The generated Vault ID"
}

output "oci_kms_master_encryption_keys_ids" {
  value       = module.k3s_oci_kms.master_encryption_keys_ids
  description = "The generated master encryption keys (MEKs)"
}
