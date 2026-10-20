output "workspace_names" {
  description = "Names of Log Analytics Workspaces"

  value = {
    for key, workspace in azurerm_log_analytics_workspace.LAW :
    key => workspace.name
  }
}

output "workspace_ids" {
  description = "Resource IDs of Log Analytics Workspaces"

  value = {
    for key, workspace in azurerm_log_analytics_workspace.LAW :
    key => workspace.id
  }
}

output "workspace_customer_ids" {
  description = "Workspace IDs used by monitoring integrations"

  value = {
    for key, workspace in azurerm_log_analytics_workspace.LAW :
    key => workspace.workspace_id
  }
}