output "metric_alert_ids" {
  description = "IDs of created metric alert rules"

  value = {
    for key, alert in azurerm_monitor_metric_alert.this :
    key => alert.id
  }
}

output "metric_alert_names" {
  description = "Names of created metric alert rules"

  value = {
    for key, alert in azurerm_monitor_metric_alert.this :
    key => alert.name
  }
}