variable "do_base_domain" {
  type        = string
  description = "The base domain to use"
}

variable "do_create_acme_domain" {
  type        = string
  description = "Enter 'true' to create the ACME delegation domain."
  default     = "false"
  validation {
    condition     = contains(["true", "false"], var.do_create_acme_domain)
    error_message = "The value must be either 'true' or 'false'."
  }
}
