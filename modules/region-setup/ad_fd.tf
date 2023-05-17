variable "ad_count" {
  type        = number
  description = "The number of Availability Domains in the region"
  default     = 1
}

variable "tenancy_ocid" {
  type        = string
  description = "The OCI Tenancy ID"
}

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

output "availability_domains" {
  value       = { for ad in data.oci_identity_availability_domain.ads : ad.name => ad.id }
  description = "Tenancy's Availability Domains"
}

output "fault_domains" {
  value       = { for ad, attributes in data.oci_identity_fault_domains.fds : ad => { for fd in attributes.fault_domains : fd.name => fd.id } }
  description = "Tenancy's Fault Domains, per each Availability Domain"
}
