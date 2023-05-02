terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    google = {
      source = "hashicorp/google"
    }
    oci = {
      source = "oracle/oci"
    }
    config = {
      source = "alabuel/config"
    }
  }
  backend "gcs" {}
  required_version = "~> 1.4.0"
}

provider "config" {}

provider "digitalocean" {
  token = var.do_token
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
