# Variables
variable "oci_compartments" {
  type = list(object(
    {
      name : string
      description : string
    }
  ))
  description = "A list of OCI compartments to create"
  # TODO: name validation
}

# Resources
module "oci_compartments" {
  for_each = { for compartment in var.oci_compartments : compartment.name => compartment.description }

  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-compartment?ref=v1.0.0"

  oci_tenancy             = var.oci_tenancy_id
  compartment_first_level = true
  compartment_description = each.value
  compartment_name        = each.key
}

# Outputs
output "compartments" {
  value       = { for compartment in var.oci_compartments : compartment.name => module.oci_compartments[compartment.name].id }
  description = "A map of compartments and their IDs."
}
