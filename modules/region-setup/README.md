# prerequisites

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
# Why yet another root module?

Unfortunately, Oracle Cloud has a pretty bad way to provide pieces of information about Availability Domains (ADs) and Fault Domains (FDs): two data sources with mandatory reference from FDs to the respective AD.

This might sound nice, but in practice breaks the `plan`, because you can't use `for_each` on maps where you only know keys during the `apply` phase.

```txt
╷
│ Error: Invalid for_each argument
│
│   on .terraform/modules/k3s_networking/modules/oci-networking/networks.tf line 20, in resource "oci_core_subnet" "vcn_ad_subnets":
│   20:   for_each = var.oci_availability_domains
│     ├────────────────
│     │ var.oci_availability_domains is a map of string, known only after apply
│
│ The "for_each" map includes keys derived from resource attributes that
│ cannot be determined until apply, and so Terraform cannot determine the
│ full set of keys that will identify the instances of this resource.
│
│ When working with unknown values in for_each, it's better to define the map
│ keys statically in your configuration and place apply-time results only in
│ the map values.
│
│ Alternatively, you could use the -target planning option to first apply
│ only the resources that the for_each value depends on, and then apply a
│ second time to fully converge.
```

I broke the loop by setting explicitly the number of AD to fetch; it's a value that should not change much (here's the [official page](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm)), and it should be part of your due diligence when signing up for a new account.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | 4.87.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 4.87.0 |

## Resources

| Name | Type |
|------|------|
| [oci_identity_availability_domain.ads](https://registry.terraform.io/providers/oracle/oci/4.87.0/docs/data-sources/identity_availability_domain) | data source |
| [oci_identity_fault_domains.fds](https://registry.terraform.io/providers/oracle/oci/4.87.0/docs/data-sources/identity_fault_domains) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ad_count"></a> [ad\_count](#input\_ad\_count) | The number of Availability Domains in the region | `number` | `1` | no |
| <a name="input_oci_private_key"></a> [oci\_private\_key](#input\_oci\_private\_key) | The private key to access OCI APIs | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The OCI tenancy ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ads"></a> [ads](#output\_ads) | Tenancy's Availability Domains |
| <a name="output_fds"></a> [fds](#output\_fds) | Tenancy's Fault Domain, per each Availability Domain |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
