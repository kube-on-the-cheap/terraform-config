locals {
  k3s_workers_config_path = "/etc/rancher/k3s/config.yaml.d/worker.terraform.yaml"
  k3s_workers_tags = {
    "K3s-NodeInfo.NodeRole" : "worker",
    "K3s-ClusterSecrets.agent-token" : oci_vault_secret.tokens["agent-token"].id
  }
}
