module "k3s_networking" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-networking?ref=v1.0.0"

  oci_compartment_id            = module.oci_compartments[local.k3s_compartment_name].id
  oci_region                    = var.oci_region
  oci_availability_domains      = local.k3s_availability_domains
  oci_networks_vcn_display_name = var.oci_vcn_attributes.display_name
  oci_networks_vcn_dns_label    = var.oci_vcn_attributes.dns_label
  oci_networks_vcn_cidr         = var.oci_vcn_attributes.cidr

  public_zone_name = var.k3s_dns_public_zone_name
}
