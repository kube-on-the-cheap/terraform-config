terraform {
  source = "../..//modules/project-setup/"
}

include "general" {
  path = find_in_parent_folders("general.include.hcl")
  # INFO: You can either set 'expose = true' and access all the included locals, or leverage
  #       the default shallow merge and define an input on the included module that will be
  #       inherited by all child modules
}

inputs = {
  # DigitalOcean Setup
  do_base_domain        = "cloud.blacksd.tech"
  do_create_acme_domain = "true"

  # Google Cloud Setup
  gcp_notifications_spending_alerts = "marco.bulgarini@gmail.com"
}
