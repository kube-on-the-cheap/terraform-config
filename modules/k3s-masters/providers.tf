# Terraform Config
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

# Variables
variable "private_key" {
  type        = string
  sensitive   = true
  description = "The OCI private key"
}

variable "tenancy_ocid" {
  type        = string
  description = "The OCI Tenancy ID"
}

variable "region" {
  type        = string
  description = "The OCI Region"
}

# Providers
provider "oci" {
  private_key = var.private_key
}
