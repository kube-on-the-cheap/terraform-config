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
| <a name="provider_local"></a> [local](#provider\_local) | 2.4.1 |
| <a name="provider_oci"></a> [oci](#provider\_oci) | 5.22.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_do_lb_records"></a> [do\_lb\_records](#module\_do\_lb\_records) | git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/do-domain | v1.0.0 |
| <a name="module_k3s_masters"></a> [k3s\_masters](#module\_k3s\_masters) | git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-k3s-masters | feat/k3s-iam |

## Resources

| Name | Type |
|------|------|
| [local_file.master_rsa_public_key_openssh](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.master_rsa_public_key_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_sensitive_file.master_rsa_private_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [oci_vault_secret.etcd_s3_secret_key](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/vault_secret) | resource |
| [oci_vault_secret.tokens](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/vault_secret) | resource |
| [random_password.tokens](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ampere_a1_allocation_schema"></a> [ampere\_a1\_allocation\_schema](#input\_ampere\_a1\_allocation\_schema) | The resource allocation schema for flexible Ampere A1 instances | `map(number)` | n/a | yes |
| <a name="input_component_versions"></a> [component\_versions](#input\_component\_versions) | (optional) describe your variable | <pre>object({<br>    k3s    = string<br>    cilium = string<br>  })</pre> | n/a | yes |
| <a name="input_do_oci_domain"></a> [do\_oci\_domain](#input\_do\_oci\_domain) | The DO domain used for OCI operations | `string` | n/a | yes |
| <a name="input_k3s_buckets"></a> [k3s\_buckets](#input\_k3s\_buckets) | A map of role an name of buckets to use | `map(string)` | n/a | yes |
| <a name="input_k3s_compartment_id"></a> [k3s\_compartment\_id](#input\_k3s\_compartment\_id) | (optional) describe your variable | `string` | n/a | yes |
| <a name="input_k3s_nodes_config_only"></a> [k3s\_nodes\_config\_only](#input\_k3s\_nodes\_config\_only) | Run the configuration playbook only, don't perform the bootstrap phase | `bool` | `false` | no |
| <a name="input_oci_availability_domains"></a> [oci\_availability\_domains](#input\_oci\_availability\_domains) | (optional) describe your variable | `map(string)` | n/a | yes |
| <a name="input_oci_etcd_bucket_s3_credentials"></a> [oci\_etcd\_bucket\_s3\_credentials](#input\_oci\_etcd\_bucket\_s3\_credentials) | Credentials to access OCI buckets via S3 Compatibility | `map(string)` | n/a | yes |
| <a name="input_oci_kms_secrets_master_encryption_key_id"></a> [oci\_kms\_secrets\_master\_encryption\_key\_id](#input\_oci\_kms\_secrets\_master\_encryption\_key\_id) | The MEK ID used to encrypt tokens | `string` | n/a | yes |
| <a name="input_oci_kms_vault_id"></a> [oci\_kms\_vault\_id](#input\_oci\_kms\_vault\_id) | The Vault ID to store Agent and Token secrets | `string` | n/a | yes |
| <a name="input_oci_network_security_groups"></a> [oci\_network\_security\_groups](#input\_oci\_network\_security\_groups) | (optional) describe your variable | `map(string)` | n/a | yes |
| <a name="input_oci_vcn_regional_subnet_compute_id"></a> [oci\_vcn\_regional\_subnet\_compute\_id](#input\_oci\_vcn\_regional\_subnet\_compute\_id) | (optional) describe your variable | `string` | n/a | yes |
| <a name="input_oci_vcn_regional_subnets_lb_ids"></a> [oci\_vcn\_regional\_subnets\_lb\_ids](#input\_oci\_vcn\_regional\_subnets\_lb\_ids) | (optional) describe your variable | `list(string)` | n/a | yes |
| <a name="input_output_path"></a> [output\_path](#input\_output\_path) | (optional) describe your variable | `string` | n/a | yes |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | The OCI private key | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The OCI Region | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCI Tenancy ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_master_instances_ids"></a> [master\_instances\_ids](#output\_master\_instances\_ids) | A list of Instance IDs in state RUNNING |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
