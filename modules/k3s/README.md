# eu-frankfurt-1

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.2.3 |
| <a name="provider_oci"></a> [oci](#provider\_oci) | 4.87.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_do_lb_records"></a> [do\_lb\_records](#module\_do\_lb\_records) | git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/do-domain | v1.0.0 |
| <a name="module_k3s_masters"></a> [k3s\_masters](#module\_k3s\_masters) | git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-k3s-compute | v1.1.0 |
| <a name="module_k3s_workers"></a> [k3s\_workers](#module\_k3s\_workers) | git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-k3s-compute | v1.1.0 |

## Resources

| Name | Type |
|------|------|
| [local_file.master_rsa_public_key_openssh](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.master_rsa_public_key_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.worker_rsa_public_key_openssh](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.worker_rsa_public_key_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_sensitive_file.master_rsa_private_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.worker_rsa_private_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [oci_vault_secret.etcd_s3_secret_key](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/vault_secret) | resource |
| [oci_vault_secret.tokens](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/vault_secret) | resource |
| [random_password.tokens](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_do_oci_domain"></a> [do\_oci\_domain](#input\_do\_oci\_domain) | The DO domain used for OCI operations | `string` | n/a | yes |
| <a name="input_do_token"></a> [do\_token](#input\_do\_token) | The DO API token | `string` | n/a | yes |
| <a name="input_k3s_compartment_id"></a> [k3s\_compartment\_id](#input\_k3s\_compartment\_id) | (optional) describe your variable | `string` | n/a | yes |
| <a name="input_k3s_nodes_config_only"></a> [k3s\_nodes\_config\_only](#input\_k3s\_nodes\_config\_only) | Run the configuration playbook only, don't perform the bootstrap phase | `bool` | `false` | no |
| <a name="input_oci_availability_domains"></a> [oci\_availability\_domains](#input\_oci\_availability\_domains) | (optional) describe your variable | `map(string)` | n/a | yes |
| <a name="input_oci_etcd_bucket_s3_credentials"></a> [oci\_etcd\_bucket\_s3\_credentials](#input\_oci\_etcd\_bucket\_s3\_credentials) | Credentials to access OCI buckets via S3 Compatibility | `map(string)` | n/a | yes |
| <a name="input_oci_kms_secrets_master_encryption_key_id"></a> [oci\_kms\_secrets\_master\_encryption\_key\_id](#input\_oci\_kms\_secrets\_master\_encryption\_key\_id) | The MEK ID used to encrypt tokens | `string` | n/a | yes |
| <a name="input_oci_kms_vault_id"></a> [oci\_kms\_vault\_id](#input\_oci\_kms\_vault\_id) | The Vault ID to store Agent and Token secrets | `string` | n/a | yes |
| <a name="input_oci_network_security_groups"></a> [oci\_network\_security\_groups](#input\_oci\_network\_security\_groups) | (optional) describe your variable | `map(string)` | n/a | yes |
| <a name="input_oci_tenancy_id"></a> [oci\_tenancy\_id](#input\_oci\_tenancy\_id) | The OCI Tenancy ID | `string` | n/a | yes |
| <a name="input_oci_vcn_subnet_id"></a> [oci\_vcn\_subnet\_id](#input\_oci\_vcn\_subnet\_id) | (optional) describe your variable | `string` | n/a | yes |
| <a name="input_output_path"></a> [output\_path](#input\_output\_path) | (optional) describe your variable | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_master_instances_ids"></a> [master\_instances\_ids](#output\_master\_instances\_ids) | A map of Instance IDs and their public IP addresses |
| <a name="output_worker_instances_ids"></a> [worker\_instances\_ids](#output\_worker\_instances\_ids) | A map of Instance IDs and their public IP addresses |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
