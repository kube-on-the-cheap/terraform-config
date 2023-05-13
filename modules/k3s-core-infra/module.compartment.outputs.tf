output "compartments" {
  value       = { for compartment in var.oci_compartments : compartment.name => module.oci_compartments[compartment.name].id }
  description = "A map of compartments and their IDs."
}
