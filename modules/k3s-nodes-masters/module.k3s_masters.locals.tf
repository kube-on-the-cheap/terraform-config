locals {
  k3s_masters_config_path = "/etc/rancher/k3s/config.yaml.d/master.terraform.yaml"
  k3s_masters_tags = merge(
    var.k3s_defined_tags,
    {
      "K3s-NodeInfo.NodeRole" : "master",
    }
  )
  k3s_api_lb_fqdn = format("kube.%s", var.do_oci_domain)
}
