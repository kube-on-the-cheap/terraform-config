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
