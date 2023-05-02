variable "oci_compartments" {
  /*
  oci_compartments_config = [
    {
      name        = "k3s"
      description = "An OCI Compartment to store all K3s-related resources"
    }
  ]
  */

  type = list(object(
    {
      name : string
      description : string
    }
  ))
  description = "A list of OCI compartments to create"
  # TODO: name validation
}
