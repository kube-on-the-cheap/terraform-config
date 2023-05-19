# Variables
variable "oci_compartments" {
  type = object(
    {
      name : string
      description : string
    }
  )
  description = "Attributes of the OCI compartment to create"
}

# Locals

# Resources
resource "oci_identity_compartment" "k3s_compartment" {
  compartment_id = var.tenancy_ocid

  description = var.oci_compartments.description
  name        = var.oci_compartments.name
  # freeform_tags = var.compartment_tags.freeform

  lifecycle {
    ignore_changes = [
      freeform_tags
    ]
  }

}

# Outputs
output "oci_compartment" {
  description = "A map of compartments and their IDs."
  value = {
    (oci_identity_compartment.k3s_compartment.name) : oci_identity_compartment.k3s_compartment.id
  }
}
