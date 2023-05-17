data "oci_identity_availability_domains" "k3s_ad" {
  compartment_id = oci_identity_compartment.k3s_compartment.id
}
