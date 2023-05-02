output "oci_config_common" {
  description = "The OCI configuration parameters, without sensitive data"
  value       = module.oci_config.common
}

output "oci_config_sensitive" {
  sensitive   = true
  description = "The OCI configuration parameters, without sensitive data"
  value       = module.oci_config.sensitive
}
