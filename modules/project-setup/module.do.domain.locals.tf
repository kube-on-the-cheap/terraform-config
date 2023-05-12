locals {
  do_domains = {
    oci  = format("oracle.%s", var.do_base_domain)
    acme = format("_acme-challenge.%s", var.do_base_domain)
  }
}
