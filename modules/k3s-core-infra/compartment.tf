variable "oci_compartments" {
  type = object(
    {
      name : string
      description : string
    }
  )
  description = "Attributes of the OCI compartment to create"
}


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

output "compartments" {
  description = "A map of compartments and their IDs."
  value = {
    "name" : oci_identity_compartment.k3s_compartment.name,
    "id" : oci_identity_compartment.k3s_compartment.id
  }
}
