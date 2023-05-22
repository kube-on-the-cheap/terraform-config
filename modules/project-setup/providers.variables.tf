variable "do_token" {
  type        = string
  sensitive   = true
  description = "The DO API token"
}

variable "gcp_project_name" {
  type        = string
  description = "The GCP project name"
}
