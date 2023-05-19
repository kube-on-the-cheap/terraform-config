locals {
  do_domains = {
    oci  = format("oci.%s", var.do_base_domain)
    gcp  = format("gcp.%s", var.do_base_domain)
    acme = format("_acme-challenge.%s", var.do_base_domain)
  }
}
