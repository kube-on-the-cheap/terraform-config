terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "4.87.0"
    }
  }
  required_version = "~> 1.4.0"

  backend "gcs" {}
}

provider "oci" {
  private_key = var.oci_private_key
}
