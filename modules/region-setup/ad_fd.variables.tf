variable "tenancy_ocid" {
  type        = string
  description = "The OCI tenancy ID"
}

variable "ad_count" {
  type        = number
  description = "The number of Availability Domains in the region"
  default     = 1
}
