output "action_group_ids" {
  description = "IDs of Azure Monitor Action Groups"

  value = {
    for key, action_group in azurerm_monitor_action_group.AG :
    key => action_group.id
  }
}