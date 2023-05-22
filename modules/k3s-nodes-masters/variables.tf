variable "k3s_nodes_config_only" {
  type        = bool
  description = "Run the configuration playbook only, don't perform the bootstrap phase"
  default     = false
}

variable "tenancy_ocid" {
  type        = string
  description = "The OCI Tenancy ID"
}
