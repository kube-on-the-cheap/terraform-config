locals {
  k3s_masters_config_path = "/etc/rancher/k3s/config.yaml.d/master.terraform.yaml"
  k3s_masters_tags = merge(
    { for name, secret in oci_vault_secret.tokens :
      format("K3s-ClusterSecrets.%s", name) => secret.id
    },
    {
      "K3s-NodeInfo.NodeRole" : "master",
      "K3s-ClusterSecrets.etcd-s3-secret-key" : oci_vault_secret.etcd_s3_secret_key.id # gitleaks:allow
    }
  )
  k3s_api_lb_fqdn = format("kube.%s", var.do_oci_domain)
}
