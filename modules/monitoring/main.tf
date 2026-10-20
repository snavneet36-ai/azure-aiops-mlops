resource "azurerm_log_analytics_workspace" "LAW" {
  for_each = var.monitoring_workspaces

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = "PerGB2018"
  retention_in_days   = each.value.retention_in_days

  tags = {
    project    = "aiops-mlops"
    managed_by = "terraform"
  }
}