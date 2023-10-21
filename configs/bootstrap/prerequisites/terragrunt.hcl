terraform {
  source = "../../..//modules/prerequisites/"
}

include "general" {
  path = find_in_parent_folders("general.include.hcl")
}

locals {
  general_values = yamldecode(file(find_in_parent_folders("general.values.yaml")))
}


inputs = merge(
  yamldecode(sops_decrypt_file("secrets.sops.yaml")),
  {
  gcp_project_id = local.general_values.project_name

  do_base_domain                    = "blacksd.tech"
  do_create_acme_domain             = "true"
  gcp_notifications_spending_alerts = "marco.bulgarini@gmail.com"
  gcp_service_list = [
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "billingbudgets.googleapis.com",
    "cloudbilling.googleapis.com"
  ]
  }
)
