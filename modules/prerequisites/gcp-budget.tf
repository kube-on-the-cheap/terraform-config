data "google_project" "project" {
}

resource "google_billing_budget" "budget" {
  provider = google.billing

  billing_account = data.google_project.project.billing_account
  display_name    = "Zero-cost Budget"

  budget_filter {
    projects = ["projects/${data.google_project.project.number}"]
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
    disable_default_iam_recipients = true
  }
}

resource "google_monitoring_notification_channel" "notification_channel" {
  display_name = "Spending Alerts Notification Channel"
  type         = "email"

  labels = {
    email_address = var.gcp_notifications_spending_alerts
  }
}
