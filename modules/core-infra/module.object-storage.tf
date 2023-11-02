# Variables
variable "k3s_oci_buckets" {
  type = map(object({
    # Standard, Archive
    storage_tier : string
    # Disabled, Enabled, Suspended
    versioning : string
    read_only : bool
    group_allow_access : optional(string),
    retention : optional(string)
    create_s3_access_key : optional(bool, false)
  }))
  description = "The description of buckets to create"
  # https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm#bucketnames
  validation {
    condition     = length([for bucket_name in keys(var.k3s_oci_buckets) : bucket_name if length(bucket_name) >= 1 && length(bucket_name) <= 256]) > 0
    error_message = "Please enter at least a bucket name, within the Oracle Cloud naming convention."
  }
}

# Resources
module "k3s_object_storage" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-object-storage?ref=v1.0.0"

  oci_compartment_id = module.oci_compartments[local.k3s_compartment_name].id
  oci_tenancy_id     = var.tenancy_ocid
  oci_region         = var.region
  oci_kms_id         = module.k3s_oci_kms.master_encryption_keys_ids["object_storage"]
  oci_buckets        = var.k3s_oci_buckets
}

# Outputs
output "oci_etcd_bucket_s3_credentials" {
  description = "Credentials to access OCI buckets via S3 Compatibility"
  sensitive   = true
  value       = module.k3s_object_storage.s3_credentials
}
