/* resource "local_sensitive_file" "kubeconfig" {
  content         = module.k3s-workers.kubeconfig.content
  filename        = "${var.output_path}/outputs/.kube/config"
  file_permission = "0600"
}
 */

# The keys to connect via SSH to the created instances
resource "local_sensitive_file" "worker_rsa_private_key" {
  content         = module.k3s_workers.rsa_private_key
  filename        = "${var.output_path}/outputs/keys/worker-rsa-key"
  file_permission = "0600"
}

resource "local_file" "worker_rsa_public_key_pem" {
  content         = module.k3s_workers.rsa_public_key.pem
  filename        = "${var.output_path}/outputs/keys/worker-rsa-key.pub"
  file_permission = "0600"
}

resource "local_file" "worker_rsa_public_key_openssh" {
  content         = module.k3s_workers.rsa_public_key.openssh
  filename        = "${var.output_path}/outputs/keys/worker-rsa-key.ssh"
  file_permission = "0600"
}

output "worker_instances_ids" {
  value       = module.k3s_workers.instances_ids
  description = "A map of Instance IDs and their public IP addresses"
}
