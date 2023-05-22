terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    google = {
      source = "hashicorp/google"
    }
  }
  backend "gcs" {}
  required_version = "~> 1.4.0"
}

provider "digitalocean" {
  token = var.do_token
}

provider "google" {
  project = var.gcp_project_name
}

provider "google" {
  alias = "billing"

  # For setting the specific billing usage header
  billing_project       = var.gcp_project_name
  user_project_override = true
}
