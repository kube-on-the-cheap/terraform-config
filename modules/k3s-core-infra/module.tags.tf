module "k3s_oci_tags" {
  # Call this module once for every namespace to provision
  for_each = { for config in var.k3s_oci_tags : config.namespace.name => config }

  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-tags?ref=v1.0.0"

  oci_compartment_id                      = oci_identity_compartment.k3s_compartment.id
  oci_tenancy_id                          = var.tenancy_ocid
  oci_iam_dynamic_group_all_instances_k3s = oci_identity_dynamic_group.dynamic_group_all_instances_k3s.name
  tag_namespace                           = each.value.namespace
  tags                                    = each.value.tags
}
