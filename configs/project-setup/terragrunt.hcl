terraform {
  source = "../..//modules/project-setup/"
}

include "general" {
  path = find_in_parent_folders("general.include.hcl")
}

inputs = {
  # DigitalOcean Setup
  do_base_domain        = "cloud.blacksd.tech"
  do_create_acme_domain = "true"

  # Google Cloud Setup
  gcp_notifications_spending_alerts = "marco.bulgarini@gmail.com"
}
