module "k3s_networking" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-networking?ref=feat/network-module"

  oci_compartment_id            = oci_identity_compartment.k3s_compartment.id
  oci_region                    = var.oci_region
  oci_availability_domains      = var.oci_ads
  oci_networks_vcn_display_name = var.oci_vcn_attributes.display_name
  oci_networks_vcn_dns_label    = var.oci_vcn_attributes.dns_label
  oci_networks_vcn_cidr         = var.oci_vcn_attributes.cidr
  public_zone_name              = var.k3s_dns_public_zone_name
}
