remote_state {
  backend      = "gcs"
  disable_init = tobool(get_env("TERRAGRUNT_DISABLE_INIT", "false"))
  config = {
    bucket   = format("kube-on-the-cheap-%s", local.tfstate_unique_string)
    prefix   = path_relative_to_include()
    project  = local.general_values.gcp_project_name
    location = local.general_values.gcp_region
  }
}

locals {
  general_values  = yamldecode(file(find_in_parent_folders("general.values.yaml")))
  general_secrets = yamldecode(sops_decrypt_file(find_in_parent_folders("general.secrets.sops.yaml")))

  tfstate_secrets = yamldecode(sops_decrypt_file(find_in_parent_folders("tfstate.secrets.sops.yaml")))
  tfstate_unique_string = substr(
    sha256(
      lookup(local.tfstate_secrets, "tfstate_unique_string_seed")
    )
  , 0, 6)
}

inputs = merge(local.general_values, local.general_secrets)

terraform_version_constraint  = "~> 1.4.0"
terragrunt_version_constraint = "~> 0.38.0"
