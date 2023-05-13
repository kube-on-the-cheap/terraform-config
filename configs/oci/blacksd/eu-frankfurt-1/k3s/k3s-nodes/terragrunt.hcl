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

dependency "k3s_core_infra" {
  config_path = "..//k3s-core-infra/"

  # mock_outputs_allowed_terraform_commands = ["validate", "init"]
  # mock_outputs                            = file("..//core-infra.mock.hcl")
}

inputs = {
  oci_tenancy_id = dependency.project_setup.outputs.oci_config_common.tenancy
  oci_region     = dependency.project_setup.outputs.oci_config_common.region
  # k3s_dns_public_zone_name = dependency.project_setup.outputs.do_domains.oci


  oci_vcn_subnet_id           = dependency.k3s_core_infra.outputs.oci_vcn_regional_subnet["eu-frankfurt-1"].id
  oci_network_security_groups = dependency.k3s_core_infra.outputs.oci_vcn_nsgs
  oci_availability_domains    = dependency.k3s_core_infra.outputs.k3s_ads
  # load_balancers              = module.networking.load_balancers
  k3s_compartment_id     = dependency.k3s_core_infra.outputs.compartments.k3s
  output_path            = get_terragrunt_dir()
  k3s_version            = "1.23.1"
  k3s_calico_version     = "1.19.3"
  do_oci_domain          = dependency.project_setup.outputs.do_domains.oci
  k3s_config_bucket_name = "k3s_kubeconfig"
  ampere_a1_allocation_schema = {
    "copper" = [
      {
        "role"  = "master"
        "count" = 1
      }
    ]
    "platinum" = [
      {
        "role"  = "worker"
        "count" = 2
      }
    ]
  }
  oci_kms_vault_id                         = dependency.k3s_core_infra.outputs.oci_kms_vault_id
  oci_kms_secrets_master_encryption_key_id = dependency.k3s_core_infra.outputs.oci_kms_master_encryption_keys_ids["secrets"]
  oci_etcd_bucket_s3_credentials           = dependency.k3s_core_infra.outputs.oci_etcd_bucket_s3_credentials["k3s_etcd_backup"]
}
