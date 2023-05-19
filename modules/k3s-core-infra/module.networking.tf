# Variables
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

# Locals

# Resources
module "k3s_networking" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-networking?ref=feat/network-module"

  oci_compartment_id            = oci_identity_compartment.k3s_compartment.id
  oci_region                    = var.oci_region
  oci_availability_domains      = var.oci_ads
  oci_networks_vcn_display_name = var.oci_vcn_attributes.display_name
  oci_networks_vcn_dns_label    = var.oci_vcn_attributes.dns_label
  oci_networks_vcn_cidr         = var.oci_vcn_attributes.cidr
  public_zone_name              = var.k3s_dns_public_zone_name
}

# Outputs
output "oci_vcn_regional_subnet" {
  value       = module.k3s_networking.vcn_regional_subnet
  description = "The K3s VCN regional subnet"
}

output "oci_vcn_ad_subnets" {
  value       = module.k3s_networking.vcn_ad_subnets
  description = "A map of K3s VCN AD subnets"
}

output "oci_vcn_nsgs" {
  value       = module.k3s_networking.network_security_groups
  description = "Network Security Groups for K3s"
}
