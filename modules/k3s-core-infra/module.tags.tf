# Variables
variable "k3s_oci_tags" {
  type = list(object(
    {
      namespace : object({
        name : string
        description : string
      })
      tags : map(object({
        description : string,
        allowed_values : optional(list(string), [])
      }))
    }
  ))
  description = "A list of tags namespaces and their composition, including the compartment they live in"
}

# Locals

# Resources
module "k3s_oci_tags" {
  # Call this module once for every namespace to provision
  for_each = { for config in var.k3s_oci_tags : config.namespace.name => config }

  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-tags?ref=v1.3.0"

  oci_compartment_id                      = oci_identity_compartment.k3s_compartment.id
  oci_tenancy_id                          = var.tenancy_ocid
  oci_iam_dynamic_group_all_instances_k3s = oci_identity_dynamic_group.dynamic_group_all_instances_k3s.name
  tag_namespace                           = each.value.namespace
  tags                                    = each.value.tags
}

# Outputs
