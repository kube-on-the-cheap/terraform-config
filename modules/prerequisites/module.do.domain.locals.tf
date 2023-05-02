locals {
  do_domains = {
    oci  = format("%s.oracle.cloud.%s", module.oci_config.common.region, var.do_base_domain)
    acme = format("_acme-challenge.cloud.%s", var.do_base_domain)
  }
}
