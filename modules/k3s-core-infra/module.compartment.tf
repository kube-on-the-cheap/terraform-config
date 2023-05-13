module "oci_compartments" {
  for_each = { for compartment in var.oci_compartments : compartment.name => compartment.description }

  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-compartment?ref=v1.0.0"

  oci_tenancy             = var.oci_tenancy_id
  compartment_first_level = true
  compartment_description = each.value
  compartment_name        = each.key
}

/*
module "shared_compartment" {
  source = "../../../modules/oci-compartment/"

  oci_tenancy             = module.config.config_oci.tenancy
  compartment_first_level = true
  compartment_description = "Shared Infrastructure Components"
  compartment_name        = "shared"
}
*/
