variable "k3s_oci_keys" {
  type        = map(string)
  description = "A map of key names and their types to create"
  validation {
    condition     = length([for name, type in var.k3s_oci_keys : name if contains(["aes", "rsa", "ecdsa"], type)]) > 0
    error_message = "You must specify at least one key to provision, and the type must be one of \"aes\", \"rsa\" or \"ecdsa\"."
  }
}
