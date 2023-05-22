# Variables
variable "k3s_oci_buckets" {
  type = map(object({
    # Standard, Archive
    storage_tier : string
    # Disabled, Enabled, Suspended
    versioning : string
    group_allow_access : optional(string),
    retention : optional(string)
    create_s3_access_key : optional(bool, false)
  }))
  description = "The description of buckets to create"
}

# Locals
locals {
  # NOTE: This is the definition of a special "k3s_etcd_backup" bucket
  k3s_etcd_backup_bucket_def = {
    k3s_etcd_backup = {
      versioning           = "Enabled"
      storage_tier         = "Standard"
      read_only            = false
      create_s3_access_key = true
    }
  }
  # NOTE: This is the composite condition that evaluates if we want to create the special bucket and eventually merges it in the mix
  bucket_map = var.k3s_setup_etcd_backup ? merge(var.k3s_oci_buckets, local.k3s_etcd_backup_bucket_def) : var.k3s_oci_buckets
}

# Resources
module "k3s_object_storage" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-object-storage?ref=feat/network-module"

  for_each = local.bucket_map

  oci_compartment_id          = oci_identity_compartment.k3s_compartment.id
  oci_tenancy_id              = var.tenancy_ocid
  oci_region                  = var.oci_region
  bucket_name                 = each.key
  bucket_storage_tier         = each.value.storage_tier
  bucket_versioning           = each.value.versioning
  bucket_create_s3_access_key = lookup(each.value, "create_s3_access_key", null)
  oci_iam_bucket_user_domain  = var.k3s_dns_public_zone_name

  oci_kms_id = module.k3s_oci_kms.master_encryption_keys["object_storage"]
}

# Outputs
output "oci_buckets_s3_credentials" {
  description = "Credentials to access OCI buckets via S3 Compatibility"
  sensitive   = true
  value       = { for bucket, attribs in local.bucket_map : bucket => module.k3s_object_storage[bucket].s3_credentials if attribs.create_s3_access_key }
}
