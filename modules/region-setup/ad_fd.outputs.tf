output "ads" {
  value       = { for ad in data.oci_identity_availability_domain.ads : ad.name => ad.id }
  description = "Tenancy's Availability Domains"
}

output "fds" {
  value       = { for ad, attributes in data.oci_identity_fault_domains.fds : ad => { for fd in attributes.fault_domains : fd.name => fd.id } }
  description = "Tenancy's Fault Domain, per each Availability Domain"
}
