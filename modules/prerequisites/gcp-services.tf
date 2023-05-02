variable "gcp_service_list" {
  description = "The list of APIs necessary for the project"
  type        = set(string)
}

resource "google_project_service" "gcp_services" {
  for_each = var.gcp_service_list

  project = var.gcp_project_id
  service = each.key
}
