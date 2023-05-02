variable "do_token" {
  type        = string
  sensitive   = true
  description = "The DO API token"
}

variable "gcp_project_id" {
  type        = string
  description = "The GCP Project ID"
}
