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

  mock_outputs_allowed_terraform_commands = ["validate", "init"]
  mock_outputs                            = file("../../../../..//project-setup/mock_outputs.hcl")
}

inputs = {
  oci_tenancy_id           = dependency.project_setup.outputs.oci_config_common.tenancy
  oci_region               = dependency.project_setup.outputs.oci_config_common.region
  k3s_dns_public_zone_name = dependency.project_setup.outputs.do_domains.oci

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
