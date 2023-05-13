module "k3s_oci_kms" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-kms?ref=v1.0.0"

  oci_compartment_id = module.oci_compartments[local.k3s_compartment_name].id
  oci_vault_name     = var.k3s_oci_vault_name
  oci_keys           = var.k3s_oci_keys # gitleaks:allow
}
