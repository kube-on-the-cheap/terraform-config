module "k3s_masters" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-k3s-compute?ref=v1.1.0"

  cloud_init_config = templatefile(format("%s/cloud-init/masters-init.cfg.tftpl", path.module), {
    tpl_apiserver_lb_hostname   = local.k3s_api_lb_fqdn
    tpl_k3s_masters_config_path = local.k3s_masters_config_path
    tpl_etcd_s3_access_key      = var.oci_etcd_bucket_s3_credentials["ACCESS_KEY"]
    # PARAM: this is an output of core-infra
    tpl_k3s_bucket_etcd_backup = "k3s_etcd_backup"
  })
  cloud_init_script = templatefile(format("%s/cloud-init/init.sh.tftpl", path.module), {
    tpl_k3s_nodes_config_only = var.k3s_nodes_config_only
  })
  oci_compartment_id          = var.k3s_compartment_id
  oci_tenancy_id              = var.oci_tenancy_id
  oci_vcn_subnet_id           = var.oci_vcn_subnet_id
  oci_network_security_groups = var.oci_network_security_groups
  oci_availability_domains    = var.oci_availability_domains

  k3s_tags = local.k3s_masters_tags

  # PARAM: this is an output of core-infra
  k3s_bucket_names = [
    "k3s_kubeconfig",
    "k3s_etcd_backup"
  ]
  # PARAM: make this a variable
  ampere_a1_allocation_schema = {
    "copper" = 1
  }
}
