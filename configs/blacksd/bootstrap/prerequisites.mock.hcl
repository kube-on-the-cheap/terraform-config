{
  do_domains = {
    "acme" = "_acme-challenge.cloud.cane.com"
    "oci" = "oci.cloud.cane.com"
  }
  do_ns_records = {
    "_acme-challenge.cloud.cane.com" = [
      "ns1.digitalocean.com",
      "ns2.digitalocean.com",
      "ns3.digitalocean.com",
    ]
    "oci.cloud.cane.com" = [
      "ns1.digitalocean.com",
      "ns2.digitalocean.com",
      "ns3.digitalocean.com",
    ]
  }
}
