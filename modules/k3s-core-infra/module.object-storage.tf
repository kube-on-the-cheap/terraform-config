module "k3s_object_storage" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-object-storage?ref=fix/object-storage"

  for_each = var.k3s_oci_buckets

  oci_compartment_id          = oci_identity_compartment.k3s_compartment.id
  oci_tenancy_id              = var.tenancy_ocid
  oci_region                  = var.oci_region
  bucket_name                 = each.key
  bucket_storage_tier         = each.value.storage_tier
  bucket_versioning           = each.value.versioning
  bucket_create_s3_access_key = lookup(each.value, "create_s3_access_key", null)

  oci_kms_id = module.k3s_oci_kms.master_encryption_keys_ids["object_storage"]
}
