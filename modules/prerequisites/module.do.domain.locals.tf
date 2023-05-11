locals {
  do_domains = {
    oci  = format("%s.oracle.%s", module.oci_config.common.region, var.do_base_domain)
    acme = format("_acme-challenge.%s", var.do_base_domain)
  }
}
