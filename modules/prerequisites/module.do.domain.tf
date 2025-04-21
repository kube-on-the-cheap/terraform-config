# Locals
locals {
  do_domains = {
    oci  = format("oci.cloud.%s", var.do_base_domain)
    acme = format("_acme-challenge.cloud.%s", var.do_base_domain)
  }
}

# Variables
variable "do_base_domain" {
  type        = string
  description = "The base domain to use"
}

variable "do_create_acme_domain" {
  type        = string
  description = "Enter 'true' to create the ACME delegation domain."
  default     = "false"
  validation {
    condition     = contains(["true", "false"], var.do_create_acme_domain)
    error_message = "The value must be either 'true' or 'false'."
  }
}

# Resources
module "do_domain_acme" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/do-domain?ref=v1.0.0"

  do_domain     = local.do_domains.acme
  create_domain = var.do_create_acme_domain
}

module "do_domain_oci" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/do-domain?ref=v1.0.0"

  do_domain     = local.do_domains.oci
  create_domain = true
  cname_record_list = var.do_create_acme_domain ? [
    {
      name  = "_acme-challenge"
      value = format("_acme-challenge.cloud.%s.", var.do_base_domain)
    }
  ] : []
}

# Outputs
output "do_domains" {
  value       = local.do_domains
  description = "A map of scope and name of DO domains"
}

output "do_ns_records" {
  value = merge(
    { for item in module.do_domain_acme.do_ns_records : item.domain => [for record in item.records : record.value] },
    { for item in module.do_domain_oci.do_ns_records : item.domain => [for record in item.records : record.value] }
  )
  description = "A map of NS records to set for their respective domains in order to do proper delegation."
}
