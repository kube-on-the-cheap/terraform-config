module "k3s_workers" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-k3s-compute?ref=v1.1.0"

  cloud_init_config = templatefile(format("%s/cloud-init/workers-init.cfg.tftpl", path.module), {
    tpl_apiserver_lb_hostname   = local.k3s_api_lb_fqdn
    tpl_k3s_workers_config_path = local.k3s_workers_config_path
  })
  cloud_init_script = templatefile(format("%s/cloud-init/init.sh.tftpl", path.module), {
    tpl_k3s_nodes_config_only = var.k3s_nodes_config_only
  })
  oci_compartment_id          = var.k3s_compartment_id
  oci_tenancy_id              = var.oci_tenancy_id
  oci_vcn_subnet_id           = var.oci_vcn_subnet_id
  oci_network_security_groups = var.oci_network_security_groups

  oci_availability_domains      = var.oci_availability_domains
  ampere_a1_availability_domain = module.k3s_masters.ampere_a1_availability_domain

  k3s_tags = local.k3s_workers_tags

  # PARAM: make this a variable
  ampere_a1_allocation_schema = {
    "platinum" = 2
  }
}
