terraform {
  source = "../../..//modules/core-infra/"
}

include "general" {
  path = find_in_parent_folders("general.include.hcl")
}

locals {
  general_values = yamldecode(file(find_in_parent_folders("general.values.yaml")))
}

dependency "prerequisites" {
  config_path = "../..//bootstrap/prerequisites/"

  mock_outputs_allowed_terraform_commands = ["validate", "init"]
  mock_outputs                            = file("../..//bootstrap/prerequisites.mock.hcl")
}

inputs = {
  k3s_dns_public_zone_name = dependency.prerequisites.outputs.do_domains.oci

  oci_compartments   = yamldecode(file("oci_compartments.values.yaml"))
  k3s_oci_tags       = yamldecode(file("k3s_oci_tags.values.yaml"))
  k3s_oci_buckets    = yamldecode(file("k3s_oci_buckets.values.yaml"))
  k3s_oci_vault_name = "K3s"
  k3s_oci_keys = {
    "object_storage" = "aes"
    "secrets"        = "aes"
  }
  oci_vcn_attributes = {
    "display_name" = "K3s Node Network"
    "dns_label"    = "k3s"
    "cidr"         = "172.16.0.0/16"
  }
}
