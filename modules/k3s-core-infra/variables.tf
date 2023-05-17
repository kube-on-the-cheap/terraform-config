variable "tenancy_ocid" {
  type        = string
  description = "The OCI Tenancy ID"
}

variable "oci_region" {
  type        = string
  description = "The OCI Region"
}

variable "shared_freeform_tags" {
  type        = map(string)
  description = "A map of shared freeform tags"
  default     = {}
}

variable "oci_ads" {
  type        = map(string)
  description = "A map of availability domain for this tenancy"
}
