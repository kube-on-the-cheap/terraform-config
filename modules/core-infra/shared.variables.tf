variable "tenancy_ocid" {
  type        = string
  description = "The OCI Tenancy ID"
}

variable "private_key" {
  type        = string
  sensitive   = true
  description = "The OCI private key"
}

variable "region" {
  type        = string
  description = "The OCI Region"
}

variable "shared_freeform_tags" {
  type        = map(string)
  description = "A map of shared freeform tags"
  default     = {}
}
