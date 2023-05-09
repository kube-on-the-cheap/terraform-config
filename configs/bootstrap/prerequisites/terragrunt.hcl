terraform {
  source = "../../..//modules/prerequisites/"
}

include "general" {
  path = find_in_parent_folders("general.include.hcl")
}

locals {
  general_values = yamldecode(file(find_in_parent_folders("general.values.yaml")))
}

inputs = {
  # DigitalOcean Setup
  do_base_domain        = "cloud.blacksd.tech"
  do_create_acme_domain = "true"

  # Google Cloud Setup
  gcp_project_id                    = local.general_values.project_name
  gcp_notifications_spending_alerts = "marco.bulgarini@gmail.com"
}
