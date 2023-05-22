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
