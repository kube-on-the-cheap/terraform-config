locals {
  k3s_availability_domains = {
    for ad in data.oci_identity_availability_domains.k3s_ad.availability_domains : ad.name => ad.id
  }
}
