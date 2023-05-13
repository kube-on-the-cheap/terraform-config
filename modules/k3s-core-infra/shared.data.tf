data "oci_identity_availability_domains" "k3s_ad" {
  compartment_id = module.oci_compartments[local.k3s_compartment_name].id
}
