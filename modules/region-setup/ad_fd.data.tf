data "oci_identity_availability_domain" "ads" {
  count = var.ad_count

  compartment_id = var.tenancy_ocid
  ad_number      = count.index + 1
}

data "oci_identity_fault_domains" "fds" {
  for_each = toset(data.oci_identity_availability_domain.ads.*.name)

  compartment_id      = var.tenancy_ocid
  availability_domain = each.value
}
