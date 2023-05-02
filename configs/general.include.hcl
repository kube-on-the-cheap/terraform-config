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
}

terraform_version_constraint  = "~> 1.4.0"
terragrunt_version_constraint = "~> 0.38.0"
