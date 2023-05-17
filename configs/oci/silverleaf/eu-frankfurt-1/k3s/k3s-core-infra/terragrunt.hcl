terraform {
  source = "../../../../../..//modules/k3s-core-infra/"
}

include "general" {
  path = find_in_parent_folders("general.include.hcl")
}

include "tenancy" {
  path = find_in_parent_folders("tenancy.include.hcl")
}

dependency "project_setup" {
  config_path = "../../../../..//project-setup/"

  # TODO: mock
  # mock_outputs_allowed_terraform_commands = ["validate", "init"]
  # mock_outputs                            = file("../../../../..//project-setup/mock_outputs.hcl")
}

dependency "region_setup" {
  config_path = "../..//region-setup/"

  # TODO: mock
  # mock_outputs_allowed_terraform_commands = ["validate", "init"]
  # mock_outputs                            = file("../../../../..//project-setup/mock_outputs.hcl")
}

inputs = {
  k3s_dns_public_zone_name = dependency.project_setup.outputs.do_domains.oci

  oci_ads            = dependency.region_setup.outputs.availability_domains
  oci_compartments   = try(yamldecode(file("oci_compartments.values.yaml")), {})
  k3s_oci_tags       = try(yamldecode(file("k3s_oci_tags.values.yaml")), {})
  k3s_oci_buckets    = try(yamldecode(file("k3s_oci_buckets.values.yaml")), {})
  k3s_oci_vault_name = "K3s"
  k3s_oci_keys = {
    "object_storage" = "aes"
    "secrets"        = "aes"
  }
  oci_vcn_attributes = {
    "display_name" = "K3s Node Network"
    "dns_label"    = "k3s"
    "cidr"         = "172.16.1.0/16"
  }
}
