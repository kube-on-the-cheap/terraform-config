terraform {
  source = "../../../../../..//modules/k3s-nodes/"
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

dependency "region_setup" {
  config_path = "../..//region-setup/"

  # TODO: mock
  # mock_outputs_allowed_terraform_commands = ["validate", "init"]
  # mock_outputs                            = file("../../../../..//project-setup/mock_outputs.hcl")
}

dependency "k3s_core_infra" {
  config_path = "..//k3s-core-infra/"

  # mock_outputs_allowed_terraform_commands = ["validate", "init"]
  # mock_outputs                            = file("..//core-infra.mock.hcl")
}

inputs = {
  oci_vcn_subnet_id           = dependency.k3s_core_infra.outputs.oci_vcn_regional_subnet["eu-frankfurt-1"].id
  oci_network_security_groups = dependency.k3s_core_infra.outputs.oci_vcn_nsgs
  oci_availability_domains    = dependency.region_setup.outputs.availability_domains
  k3s_compartment_id          = dependency.k3s_core_infra.outputs.oci_compartment.k3s
  output_path                 = get_terragrunt_dir()
  k3s_version                 = "1.23.1"
  k3s_calico_version          = "1.19.3"
  do_oci_domain               = dependency.project_setup.outputs.do_domains.oci
  k3s_config_bucket_name      = "k3s_kubeconfig"
  masters_ampere_a1_allocation_schema = {
    "copper" = 1
  }
  workers_ampere_a1_allocation_schema = {
    "platinum" = 2
  }
  oci_kms_vault_id                         = dependency.k3s_core_infra.outputs.oci_kms_vault["K3s"]
  oci_kms_secrets_master_encryption_key_id = dependency.k3s_core_infra.outputs.oci_kms_master_encryption_keys["secrets"]
  oci_etcd_bucket_s3_credentials           = dependency.k3s_core_infra.outputs.oci_buckets_s3_credentials["k3s_etcd_backup"]
}
