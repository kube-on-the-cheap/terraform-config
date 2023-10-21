# prerequisites

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

Before running this module you must have

- Subscribed to DigitalOcean
- Subscribed to Google Cloud, and added a Billing Account
- Subscribed to Oracle Cloud

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.37.0 |
| <a name="provider_google.billing"></a> [google.billing](#provider\_google.billing) | 4.37.0 |

## Resources

| Name | Type |
|------|------|
| [google_billing_budget.budget](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/billing_budget) | resource |
| [google_monitoring_notification_channel.notification_channel](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |
| [google_project_service.gcp_services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_do_base_domain"></a> [do\_base\_domain](#input\_do\_base\_domain) | The base domain to use | `string` | n/a | yes |
| <a name="input_do_create_acme_domain"></a> [do\_create\_acme\_domain](#input\_do\_create\_acme\_domain) | Enter 'true' to create the ACME delegation domain. | `string` | `"false"` | no |
| <a name="input_gcp_billing_account_id"></a> [gcp\_billing\_account\_id](#input\_gcp\_billing\_account\_id) | The billing account ID with the payent info | `string` | n/a | yes |
| <a name="input_gcp_notifications_spending_alerts"></a> [gcp\_notifications\_spending\_alerts](#input\_gcp\_notifications\_spending\_alerts) | An email to notify about spending thresholds | `string` | n/a | yes |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | The GCP Project ID | `string` | n/a | yes |
| <a name="input_gcp_service_list"></a> [gcp\_service\_list](#input\_gcp\_service\_list) | The list of APIs necessary for the project | `set(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_do_domains"></a> [do\_domains](#output\_do\_domains) | A map of scope and name of DO domains |
| <a name="output_do_ns_records"></a> [do\_ns\_records](#output\_do\_ns\_records) | A map of NS records to set for their respective domains in order to do proper delegation. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
