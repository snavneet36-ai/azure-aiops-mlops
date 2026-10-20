resource "azurerm_monitor_action_group" "AG" {
  for_each = var.action_groups

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  short_name          = each.value.short_name

  email_receiver {
    name                    = each.value.email_name
    email_address           = each.value.email_address
    use_common_alert_schema = true
  }

  tags = {
    project    = "aiops-mlops"
    managed_by = "terraform"
  }
}