module "k3s_oci_kms" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-kms?ref=v1.3.0"

  oci_compartment_id = oci_identity_compartment.k3s_compartment.id
  oci_vault_name     = "K3s"
  oci_keys           = var.k3s_oci_keys # gitleaks:allow
}
