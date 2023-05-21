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

variable "masters_ampere_a1_allocation_schema" {
  type        = map(number)
  description = "The allocation schema of Ampere A1 master instances"
}
