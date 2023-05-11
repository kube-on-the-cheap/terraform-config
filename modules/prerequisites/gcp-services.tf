locals {
  # The list of APIs needed for this project
  gcp_service_list = [
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "billingbudgets.googleapis.com"
  ]
}

resource "google_project_service" "gcp_services" {
  for_each = toset(local.gcp_service_list)

  project = var.gcp_project_id
  service = each.key
}
