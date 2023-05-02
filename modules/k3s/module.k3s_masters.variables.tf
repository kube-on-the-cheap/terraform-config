variable "oci_vcn_subnet_id" {
  type        = string
  description = "(optional) describe your variable"
}

variable "oci_tenancy_id" {
  type        = string
  description = "The OCI Tenancy ID"
}

# TODO: delete this
# variable "oci_region" {
#   type        = string
#   description = "The OCI Region"
# }

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
