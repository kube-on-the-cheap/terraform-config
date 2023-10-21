# Variables
variable "gcp_notifications_spending_alerts" {
  type        = string
  description = "An email to notify about spending thresholds"
}

variable "gcp_billing_account_id" {
  type        = string
  sensitive   = true
  description = "The billing account ID with the payent info"
}

# Data Sources
data "google_project" "project" {}

# Resources
resource "google_billing_budget" "budget" {
  provider = google.billing

  billing_account = var.gcp_billing_account_id
  display_name    = "Zero-cost Budget"

  budget_filter {
    calendar_period = "MONTH"
    projects        = ["projects/${data.google_project.project.number}"]
  }

  amount {
    specified_amount {
      currency_code = "EUR"
      # units         = "0"
      nanos = "0"
    }
  }

  threshold_rules {
    threshold_percent = 1.0
  }
  threshold_rules {
    threshold_percent = 1.0
    spend_basis       = "FORECASTED_SPEND"
  }

  all_updates_rule {
    monitoring_notification_channels = [
      google_monitoring_notification_channel.notification_channel.id,
    ]
    disable_default_iam_recipients = false
  }
  depends_on = [google_project_service.gcp_services]
}

resource "google_monitoring_notification_channel" "notification_channel" {
  display_name = "Spending Alerts Notification Channel"
  type         = "email"

  labels = {
    email_address = var.gcp_notifications_spending_alerts
  }
}
