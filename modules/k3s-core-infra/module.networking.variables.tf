variable "oci_vcn_attributes" {
  type = object({
    display_name : string
    dns_label : string
    cidr : string
  })
  description = "An object describing attributes required to provision the VCN"
}

variable "k3s_dns_public_zone_name" {
  type        = string
  description = "The public zone name for K3s resources"
}
