variable "monitoring_workspaces" {
  description = "Map of Log Analytics Workspace configurations"

  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    retention_in_days   = number
  }))
}