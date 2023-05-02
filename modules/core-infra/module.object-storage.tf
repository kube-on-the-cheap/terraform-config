module "k3s_object_storage" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-object-storage?ref=v1.0.0"

  oci_compartment_id = module.oci_compartments[local.k3s_compartment_name].id
  oci_tenancy_id     = var.oci_tenancy_id
  oci_region         = var.oci_region
  oci_kms_id         = module.k3s_oci_kms.master_encryption_keys_ids["object_storage"]
  oci_buckets        = var.k3s_oci_buckets
}
