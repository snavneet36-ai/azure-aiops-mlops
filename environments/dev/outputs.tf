output "resource_group_names" {
  value = module.resource_group.resource_group_names
}

output "monitoring_workspace_names" {
  value = module.monitoring.workspace_names
}

output "monitoring_workspace_ids" {
  value = module.monitoring.workspace_ids
}


output "metric_alert_names" {
  value = module.monitor_alert.metric_alert_names
}

output "metric_alert_ids" {
  value = module.monitor_alert.metric_alert_ids
}