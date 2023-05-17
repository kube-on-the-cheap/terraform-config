# eu-frankfurt-1

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Intro

### IAM

Lots and lots to unpack, here. Some references:

* https://docs.oracle.com/en-us/iaas/Content/Identity/Reference/corepolicyreference.htm

* [Policy syntax](https://docs.oracle.com/en-us/iaas/Content/Identity/policysyntax/policy-syntax.htm) is where to start at.

  ```txt
  Allow <identity_domain_name>/<subject> to <verb> <resource-type> in <location> where <conditions>
  ```

* [General variables](https://docs.oracle.com/en-us/iaas/Content/Identity/policyreference/policyreference_topic-General_Variables_for_All_Requests.htm) that work for every call:

* [Common policies](https://docs.oracle.com/en-us/iaas/Content/Identity/policiescommon/commonpolicies.htm) for a good starting point. Especially the "Let Block Volume, Object Storage, File Storage, Container Engine for Kubernetes, and Streaming services encrypt and decrypt volumes, volume backups, buckets, file systems, Kubernetes secrets, and stream pools" one contains a few interesting data about the composition of non-standard syntaxes using services:

  ```txt
  Allow service blockstorage, objectstorage-<region_name>, Fss<realm_key>Prod, oke, streaming to use keys in compartment ABC where target.key.id = '<key_OCID>'
  ```

* A [working example](https://docs.oracle.com/en-us/iaas/Content/Compute/Tasks/runningcommands.htm) for setting dynamic groups with tags

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.2.3 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | 4.87.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 4.87.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_k3s_networking"></a> [k3s\_networking](#module\_k3s\_networking) | git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-networking | v1.0.0 |
| <a name="module_k3s_object_storage"></a> [k3s\_object\_storage](#module\_k3s\_object\_storage) | git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-object-storage | fix/object-storage |
| <a name="module_k3s_oci_kms"></a> [k3s\_oci\_kms](#module\_k3s\_oci\_kms) | git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-kms | v1.0.0 |
| <a name="module_k3s_oci_tags"></a> [k3s\_oci\_tags](#module\_k3s\_oci\_tags) | git::https://github.com/kube-on-the-cheap/terraform-modules.git//modules/oci-tags | v1.0.0 |

## Resources

| Name | Type |
|------|------|
| [oci_identity_compartment.k3s_compartment](https://registry.terraform.io/providers/oracle/oci/4.87.0/docs/resources/identity_compartment) | resource |
| [oci_identity_dynamic_group.dynamic_group_all_instances_k3s](https://registry.terraform.io/providers/oracle/oci/4.87.0/docs/resources/identity_dynamic_group) | resource |
| [oci_identity_availability_domains.k3s_ad](https://registry.terraform.io/providers/oracle/oci/4.87.0/docs/data-sources/identity_availability_domains) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k3s_dns_public_zone_name"></a> [k3s\_dns\_public\_zone\_name](#input\_k3s\_dns\_public\_zone\_name) | The public zone name for K3s resources | `string` | n/a | yes |
| <a name="input_k3s_oci_buckets"></a> [k3s\_oci\_buckets](#input\_k3s\_oci\_buckets) | The description of buckets to create | <pre>map(object({<br>    # Standard, Archive<br>    storage_tier : string<br>    # Disabled, Enabled, Suspended<br>    versioning : string<br>    group_allow_access : optional(string),<br>    retention : optional(string)<br>    create_s3_access_key : optional(bool, false)<br>  }))</pre> | n/a | yes |
| <a name="input_k3s_oci_keys"></a> [k3s\_oci\_keys](#input\_k3s\_oci\_keys) | A map of key names and their types to create | `map(string)` | n/a | yes |
| <a name="input_k3s_oci_tags"></a> [k3s\_oci\_tags](#input\_k3s\_oci\_tags) | A list of tags namespaces and their composition, including the compartment they live in | <pre>list(object(<br>    {<br>      namespace : object({<br>        name : string<br>        description : string<br>      })<br>      tags : map(object({<br>        description : string,<br>        allowed_values : optional(list(string), [])<br>      }))<br>    }<br>  ))</pre> | n/a | yes |
| <a name="input_k3s_oci_vault_name"></a> [k3s\_oci\_vault\_name](#input\_k3s\_oci\_vault\_name) | The OCI Vault name | `string` | n/a | yes |
| <a name="input_oci_ads"></a> [oci\_ads](#input\_oci\_ads) | A map of availability domain for this tenancy | `map(string)` | n/a | yes |
| <a name="input_oci_compartments"></a> [oci\_compartments](#input\_oci\_compartments) | Attributes of the OCI compartment to create | <pre>object(<br>    {<br>      name : string<br>      description : string<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_oci_private_key"></a> [oci\_private\_key](#input\_oci\_private\_key) | The private key to access OCI APIs | `string` | n/a | yes |
| <a name="input_oci_region"></a> [oci\_region](#input\_oci\_region) | The OCI Region | `string` | n/a | yes |
| <a name="input_oci_vcn_attributes"></a> [oci\_vcn\_attributes](#input\_oci\_vcn\_attributes) | An object describing attributes required to provision the VCN | <pre>object({<br>    display_name : string<br>    dns_label : string<br>    cidr : string<br>  })</pre> | n/a | yes |
| <a name="input_shared_freeform_tags"></a> [shared\_freeform\_tags](#input\_shared\_freeform\_tags) | A map of shared freeform tags | `map(string)` | `{}` | no |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCI Tenancy ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_compartments"></a> [compartments](#output\_compartments) | A map of compartments and their IDs. |
| <a name="output_k3s_ads"></a> [k3s\_ads](#output\_k3s\_ads) | The K3s compartment Availability Domains |
| <a name="output_oci_etcd_bucket_s3_credentials"></a> [oci\_etcd\_bucket\_s3\_credentials](#output\_oci\_etcd\_bucket\_s3\_credentials) | Credentials to access OCI buckets via S3 Compatibility |
| <a name="output_oci_kms_master_encryption_keys_ids"></a> [oci\_kms\_master\_encryption\_keys\_ids](#output\_oci\_kms\_master\_encryption\_keys\_ids) | The generated master encryption keys (MEKs) |
| <a name="output_oci_kms_vault_id"></a> [oci\_kms\_vault\_id](#output\_oci\_kms\_vault\_id) | The generated Vault ID |
| <a name="output_oci_vcn_ad_subnets"></a> [oci\_vcn\_ad\_subnets](#output\_oci\_vcn\_ad\_subnets) | A map of K3s VCN AD subnets |
| <a name="output_oci_vcn_nsgs"></a> [oci\_vcn\_nsgs](#output\_oci\_vcn\_nsgs) | Network Security Groups for K3s |
| <a name="output_oci_vcn_regional_subnet"></a> [oci\_vcn\_regional\_subnet](#output\_oci\_vcn\_regional\_subnet) | The K3s VCN regional subnet |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
