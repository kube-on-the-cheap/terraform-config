# eu-frankfurt-1

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_do_lb_records"></a> [do\_lb\_records](#module\_do\_lb\_records) | git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/do-domain | v1.0.0 |
| <a name="module_k3s_masters"></a> [k3s\_masters](#module\_k3s\_masters) | git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-k3s-compute | feat/network-module |

## Resources

| Name | Type |
|------|------|
| [local_file.master_rsa_public_key_openssh](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.master_rsa_public_key_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_sensitive_file.master_rsa_private_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ampere_a1_allocation_schema"></a> [ampere\_a1\_allocation\_schema](#input\_ampere\_a1\_allocation\_schema) | The allocation schema of Ampere A1 master instances | `map(number)` | n/a | yes |
| <a name="input_do_oci_domain"></a> [do\_oci\_domain](#input\_do\_oci\_domain) | The DO domain used for OCI operations | `string` | n/a | yes |
| <a name="input_do_token"></a> [do\_token](#input\_do\_token) | The DO API token | `string` | n/a | yes |
| <a name="input_k3s_compartment_id"></a> [k3s\_compartment\_id](#input\_k3s\_compartment\_id) | (optional) describe your variable | `string` | n/a | yes |
| <a name="input_k3s_defined_tags"></a> [k3s\_defined\_tags](#input\_k3s\_defined\_tags) | A map of defined tags to apply | `map(string)` | n/a | yes |
| <a name="input_k3s_etcd_bucket_s3_access_key"></a> [k3s\_etcd\_bucket\_s3\_access\_key](#input\_k3s\_etcd\_bucket\_s3\_access\_key) | Access Key to access OCI buckets via S3 Compatibility | `string` | n/a | yes |
| <a name="input_k3s_nodes_config_only"></a> [k3s\_nodes\_config\_only](#input\_k3s\_nodes\_config\_only) | Run the configuration playbook only, don't perform the bootstrap phase | `bool` | `false` | no |
| <a name="input_oci_availability_domains"></a> [oci\_availability\_domains](#input\_oci\_availability\_domains) | (optional) describe your variable | `map(string)` | n/a | yes |
| <a name="input_oci_network_security_groups"></a> [oci\_network\_security\_groups](#input\_oci\_network\_security\_groups) | (optional) describe your variable | `map(string)` | n/a | yes |
| <a name="input_oci_private_key"></a> [oci\_private\_key](#input\_oci\_private\_key) | The private key to access OCI APIs | `string` | n/a | yes |
| <a name="input_oci_vcn_subnet_id"></a> [oci\_vcn\_subnet\_id](#input\_oci\_vcn\_subnet\_id) | (optional) describe your variable | `string` | n/a | yes |
| <a name="input_output_path"></a> [output\_path](#input\_output\_path) | (optional) describe your variable | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCI Tenancy ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_master_instances_ids"></a> [master\_instances\_ids](#output\_master\_instances\_ids) | A map of Instance IDs and their public IP addresses |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
