/* resource "local_sensitive_file" "kubeconfig" {
  content         = module.k3s-masters.kubeconfig.content
  filename        = "${var.output_path}/outputs/.kube/config"
  file_permission = "0600"
}
 */

# The keys to connect via SSH to the created instances
resource "local_sensitive_file" "master_rsa_private_key" {
  content         = module.k3s_masters.rsa_private_key
  filename        = "${var.output_path}/outputs/keys/master-rsa-key"
  file_permission = "0600"
}

resource "local_file" "master_rsa_public_key_pem" {
  content         = module.k3s_masters.rsa_public_key.pem
  filename        = "${var.output_path}/outputs/keys/master-rsa-key.pub"
  file_permission = "0600"
}

resource "local_file" "master_rsa_public_key_openssh" {
  content         = module.k3s_masters.rsa_public_key.openssh
  filename        = "${var.output_path}/outputs/keys/master-rsa-key.ssh"
  file_permission = "0600"
}

output "master_instances_ids" {
  value       = module.k3s_masters.instances_ids
  description = "A map of Instance IDs and their public IP addresses"
}
