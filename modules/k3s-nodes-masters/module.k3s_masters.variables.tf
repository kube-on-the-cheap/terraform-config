variable "oci_vcn_subnet_id" {
  type        = string
  description = "(optional) describe your variable"
}

variable "k3s_compartment_id" {
  type        = string
  description = "(optional) describe your variable"
}

variable "oci_network_security_groups" {
  type        = map(string)
  description = "(optional) describe your variable"
}

variable "oci_availability_domains" {
  type        = map(string)
  description = "(optional) describe your variable"
}

variable "output_path" {
  type        = string
  description = "(optional) describe your variable"
}

variable "ampere_a1_allocation_schema" {
  type        = map(number)
  description = "The allocation schema of Ampere A1 master instances"
  validation {
    condition     = length(var.ampere_a1_allocation_schema) > 0
    error_message = "Please enter at least one element for the allocation schema."
  }
  validation {
    condition     = length([for k, v in var.ampere_a1_allocation_schema : k if v == 0]) == 0
    error_message = "You can't have an element with count 0."
  }
}

variable "k3s_defined_tags" {
  type        = map(string)
  description = "A map of defined tags to apply"
}

variable "k3s_etcd_bucket_s3_access_key" {
  type        = string
  description = "Access Key to access OCI buckets via S3 Compatibility"
}
