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
