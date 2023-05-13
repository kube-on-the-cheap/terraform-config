terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
    local = {
      source = "hashicorp/local"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    # Leaving version here since we're creating resources directly in this module
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = "~> 1.4.0"

  backend "gcs" {}
}

provider "digitalocean" {
  token = var.do_token
}

provider "oci" {
  private_key = var.oci_private_key
}
