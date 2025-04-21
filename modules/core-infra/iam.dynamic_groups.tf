# Trying to keep a reasonable balance between "everything in a module" and "a 1-resource module"
resource "oci_identity_dynamic_group" "dynamic_group_all_instances_k3s" {
  compartment_id = var.tenancy_ocid

  name          = "all_instances_compartment_${local.k3s_compartment_name}"
  description   = "Dynamic group which contains all instances in the K3s compartment"
  matching_rule = "All { instance.compartment.id = '${module.oci_compartments[local.k3s_compartment_name].id}' }"

  freeform_tags = var.shared_freeform_tags
}
