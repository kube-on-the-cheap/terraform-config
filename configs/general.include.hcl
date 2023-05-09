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
  general_secrets = sops_decrypt_file("${get_parent_terragrunt_dir()}/general.secrets.sops.yaml")
  general_values  = yamldecode(file("general.values.yaml"))

  tfstate_unique_string = substr(
    sha256(
      lookup(yamldecode(local.general_secrets), "tfstate_unique_string_seed")
    )
  , 0, 6)
}

terraform_version_constraint  = "~> 1.4.0"
terragrunt_version_constraint = "~> 0.38.0"
