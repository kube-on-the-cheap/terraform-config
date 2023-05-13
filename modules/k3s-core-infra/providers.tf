terraform {
  required_providers {
    # Leaving version here since we're creating resources directly in this module
    oci = {
      source  = "oracle/oci"
      version = "4.87.0"
    }
    # Leaving version here since we're creating resources directly in this module
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
  }
  required_version = "~> 1.4.0"

  backend "gcs" {}
}

provider "oci" {
  private_key = var.oci_private_key
}
