/*
output "compute_ips" {
  value     = module.compute.ips
  sensitive = true
}

output "zone_nameservers" {
  value = {
    (var.oci_dns_public_zone_name) = module.dns.zone_nameservers.*.hostname
  }
}
*/

/* output "master_ips" {
  value = module.compute.master_instances_ips
}
 */
