variable "oci_tenancy_id" {
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
