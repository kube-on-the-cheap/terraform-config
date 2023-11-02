terraform {
  extra_arguments "google_credentials" {
    commands  = get_terraform_commands_that_need_vars()
    env_vars = {
      GOOGLE_CREDENTIALS = local.gcp_key_file
    }
  }
  # https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm
  extra_arguments "oci_credentials" {
    commands  = get_terraform_commands_that_need_vars()
    env_vars = {
      TF_VAR_fingerprint = local.oci_secrets.fingerprint
      TF_VAR_region =  local.oci_secrets.region
      TF_VAR_tenancy_ocid =  local.oci_secrets.tenancy
      TF_VAR_user_ocid =  local.oci_secrets.user
      TF_VAR_private_key =  base64decode(local.oci_secrets.private_key)
    }
  }
  extra_arguments "do_credentials" {
    commands  = get_terraform_commands_that_need_vars()
    env_vars = {
      DIGITALOCEAN_TOKEN = local.do_secrets.do_token
    }
  }
}

remote_state {
  backend      = "gcs"
  disable_init = tobool(get_env("TERRAGRUNT_DISABLE_INIT", "false"))
  config = {
    bucket   = format("kube-on-the-cheap-%s", local.tfstate_unique_string)
    prefix   = format("%s/terraform.tfstate", path_relative_to_include())
    project  = local.general_values.project_name
    location = local.general_values.region
  }
}

locals {
  # We need a globally unique bucket name, and we don't have the neat AWS get_caller_id function available for GCP
  # so either we get it from the shared values file, or we assume the tuple HOST + USER offers enough entropy (lol)
  tfstate_unique_string = coalesce(
    lookup(local.general_values, "tfstate_unique_string", ""),
    substr(sha256(format("%s-%s", get_env("HOST", "acomputer"), get_env("USER", "someone"))), 0, 6)
  )
  general_values = yamldecode(file("general.values.yaml"))
  gcp_key_file = sops_decrypt_file(find_in_parent_folders("gcp_key_file.sops.json"))
  oci_secrets = jsondecode(sops_decrypt_file(find_in_parent_folders("oci.secrets.sops.json")))
  do_secrets = jsondecode(sops_decrypt_file(find_in_parent_folders("do.secrets.sops.json")))
}

terraform_version_constraint  = "~> 1.4.0"
terragrunt_version_constraint = "~> 0.38.0"
