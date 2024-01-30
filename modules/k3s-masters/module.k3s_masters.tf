# Variables
variable "oci_vcn_regional_subnet_compute_name" {
  type        = string
  description = "(optional) describe your variable"
}

variable "oci_vcn_regional_subnets_lb_ids" {
  type        = list(string)
  description = "(optional) describe your variable"
  validation {
    condition     = length(var.oci_vcn_regional_subnets_lb_ids) == 2
    error_message = "Please specify 2 regional subnets for LB HA."
  }
}

variable "component_versions" {
  type = object({
    k3s    = string
    cilium = string
  })
  description = "(optional) describe your variable"
}

variable "k3s_compartment_id" {
  type        = string
  description = "(optional) describe your variable"
}

variable "oci_network_security_groups" {
  type        = map(string)
  description = "(optional) describe your variable"
}

variable "oci_availability_domains" {
  type        = map(string)
  description = "(optional) describe your variable"
}

variable "output_path" {
  type        = string
  description = "(optional) describe your variable"
}

variable "k3s_nodes_config_only" {
  type        = bool
  description = "Run the configuration playbook only, don't perform the bootstrap phase"
  default     = false
}

variable "k3s_buckets" {
  type        = map(string)
  description = "A map of role an name of buckets to use"
}

variable "ampere_a1_allocation_schema" {
  type = map(number)
  validation {
    condition     = length([for class, count in var.ampere_a1_allocation_schema : class if contains(["wood", "copper", "silver", "gold", "platinum", "diamond"], class)]) == length(keys(var.ampere_a1_allocation_schema))
    error_message = "Please specify one of \"wood\", \"copper\", \"silver\", \"gold\", \"platinum\" or \"diamond\" as keys."
  }
  # TODO: count should be at least 1
  # validation {
  #   condition     = length([for class, params in var.ampere_a1_allocation_schema : class if contains(["wood", "copper", "silver", "gold", "platinum", "diamond"], class)]) > 0
  #   error_message = "Your map must describe at least one of the four tiers."
  # }
  # validation {
  #   condition = setsubtract([for class, params in var.ampere_a1_allocation_schema : [
  #     for item in params : item if contains(["master", "worker"], item.role) && item.count > 0
  #   ]], values(var.ampere_a1_allocation_schema)) == []
  #   error_message = "Please include only positive count values and \"master\" or \"worker\" types."
  # }
  description = "The resource allocation schema for flexible Ampere A1 instances"
}


# Locals
locals {
  k3s_config_path   = "/etc/rancher/k3s/config.yaml.d"
  ansible_vars_path = "/root/ansible-vars.yaml"
  k3s_api_lb_fqdn   = format("kube.%s", var.do_oci_domain)
}

# Resources
module "k3s_masters" {
  source = "git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-k3s-masters?ref=feat/k3s-iam"

  cloud_init_config = templatefile(format("%s/cloud-init/masters-init.cfg.tftpl", path.module), {
    # INFO: Files to create
    tpl_k3s_masters_config_path = format("%s/master.terraform.yaml", local.k3s_config_path)
    tpl_ansible_vars_path       = local.ansible_vars_path
    # INFO: Parameters for those files files to create
    tpl_apiserver_lb_hostname  = local.k3s_api_lb_fqdn
    tpl_etcd_s3_access_key     = var.oci_etcd_bucket_s3_credentials["ACCESS_KEY"]
    tpl_k3s_bucket_etcd_backup = var.k3s_buckets["etcd_backup"]
    tpl_k3s_bucket_kubeconfig  = var.k3s_buckets["kubeconfig"]
    tpl_nlb_regional_subnets   = var.oci_vcn_regional_subnets_lb_ids
    tpl_k3s_version            = var.component_versions["k3s"]
    tpl_cilium_version         = var.component_versions["cilium"]
  })
  cloud_init_script = templatefile(format("%s/cloud-init/init.sh.tftpl", path.module), {
    tpl_k3s_nodes_config_only = var.k3s_nodes_config_only
    tpl_ansible_vars_path     = local.ansible_vars_path
  })
  oci_compartment_id          = var.k3s_compartment_id
  oci_tenancy_id              = var.tenancy_ocid
  oci_vcn_subnet_id           = var.oci_vcn_regional_subnet_compute_name
  oci_network_security_groups = var.oci_network_security_groups
  oci_availability_domains    = var.oci_availability_domains

  k3s_tags_config = {
    "K3s-NodeInfo.NodeRole" : "master",
    "K3s-NodeInfo.NodeInitStatus" : "notstarted"
  }
  k3s_tags_secrets = merge(
    { for name, secret in oci_vault_secret.tokens :
      format("K3s-ClusterSecrets.%s", name) => secret.id
    },
    {
      "K3s-ClusterSecrets.etcd-s3-secret-key" : oci_vault_secret.etcd_s3_secret_key.id # gitleaks:allow
    }
  )

  k3s_bucket_names            = values(var.k3s_buckets)
  ampere_a1_allocation_schema = var.ampere_a1_allocation_schema
}

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
  description = "A list of Instance IDs in state RUNNING"
}
