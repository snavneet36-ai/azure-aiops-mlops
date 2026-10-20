resource "azurerm_monitor_metric_alert" "this" {
  for_each = var.metric_alerts

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  scopes              = [each.value.scope]

  description   = "Storage Account transaction threshold exceeded"
  severity      = each.value.severity
  enabled       = true
  auto_mitigate = true

  frequency   = each.value.frequency
  window_size = each.value.window_size

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = each.value.metric_name
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = each.value.threshold
  }
  action {
    action_group_id = each.value.action_group_ids[0]
  }
  tags = {
    project    = "aiops-mlops"
    managed_by = "terraform"
  }
}