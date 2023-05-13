variable "do_token" {
  type        = string
  sensitive   = true
  description = "The DO API token"
}

variable "oci_private_key" {
  type        = string
  sensitive   = true
  description = "The private key to access OCI APIs"
}
