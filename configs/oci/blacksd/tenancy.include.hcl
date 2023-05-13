terraform {
  extra_arguments "set_oci_config" {
    commands = get_terraform_commands_that_need_vars()
    env_vars = {
      "TF_VAR_fingerprint"  = local.tenancy_secrets.oci_fingerprint
      "TF_VAR_tenancy_ocid" = local.tenancy_secrets.oci_tenancy
      "TF_VAR_user_ocid"    = local.tenancy_secrets.oci_user
      "OCI_REGION"          = local.tenancy_values.oci_region # Mandatory but undocumented, SMH
    }
  }
}

locals {
  tenancy_values  = try(yamldecode(file(find_in_parent_folders("tenancy.values.yaml"))), {})
  tenancy_secrets = try(yamldecode(sops_decrypt_file(find_in_parent_folders("tenancy.secrets.sops.yaml"))), {})
}

inputs = {
  # Unfortunately, this cannot be passed as an env var, and I don't like the idea of passing a temporary path with a private key
  oci_private_key = local.tenancy_secrets.oci_private_key
}
