terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    google = {
      source = "hashicorp/google"
    }
    # config = {
    #   source = "alabuel/config"
    # }
  }
  backend "gcs" {}
  required_version = "~> 1.4.0"
}

# provider "config" {}

variable "gcp_project_id" {
  type        = string
  description = "The GCP Project ID"
}

provider "google" {
  project = var.gcp_project_id
}

provider "google" {
  alias = "billing"

  # For setting the specific billing usage header
  billing_project       = var.gcp_project_id
  user_project_override = true
}
