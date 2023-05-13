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
