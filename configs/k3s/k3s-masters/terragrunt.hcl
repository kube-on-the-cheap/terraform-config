terraform {
  source = "../../..//modules/k3s-masters/"
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

dependency "core_infra" {
  config_path = "..//core-infra/"

  mock_outputs_allowed_terraform_commands = ["validate", "init"]
  mock_outputs                            = file("..//core-infra.mock.hcl")
}

inputs = {
  oci_vcn_subnet_id           = dependency.core_infra.outputs.oci_vcn_regional_subnet["eu-frankfurt-1"].id
  oci_network_security_groups = dependency.core_infra.outputs.oci_vcn_nsgs
  oci_availability_domains    = dependency.core_infra.outputs.k3s_ads
  k3s_compartment_id     = dependency.core_infra.outputs.compartments.k3s
  output_path            = get_terragrunt_dir()
  # TODO: use these
  # k3s_version            = "1.28.3"
  # k3s_calico_version     = "3.26.4"
  do_oci_domain          = dependency.prerequisites.outputs.do_domains.oci
  # TODO: reference top map input from dependency core-infra
  k3s_buckets = {
    "etcd_backup" = "k3s_etcd_backup"
    "kubeconfig"  = "k3s_kubeconfig"
  }
  ampere_a1_allocation_schema = {
    "copper" = 1
  }
  oci_kms_vault_id                         = dependency.core_infra.outputs.oci_kms_vault_id
  oci_kms_secrets_master_encryption_key_id = dependency.core_infra.outputs.oci_kms_master_encryption_keys_ids["secrets"]
  oci_etcd_bucket_s3_credentials           = dependency.core_infra.outputs.oci_etcd_bucket_s3_credentials["k3s_etcd_backup"]
}
