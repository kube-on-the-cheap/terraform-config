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

variable "k3s_setup_etcd_backup" {
  type        = bool
  description = "Create all necessary stuctures to have etcd backup"
}
