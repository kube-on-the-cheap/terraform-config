output "do_domains" {
  value       = local.do_domains
  description = "A map of scope and name of DO domains"
}

output "do_ns_records" {
  value = merge(
    { for item in module.do_domain_acme.do_ns_records : item.domain => [for record in item.records : record.value] },
    { for item in module.do_domain_oci.do_ns_records : item.domain => [for record in item.records : record.value] }
  )
  description = "A map of NS records to set for their respective domains in order to do proper delegation."
}
