variable "metric_alerts" {
  description = "Map of Azure Monitor metric alert configurations"

  type = map(object({
    name                = string
    resource_group_name = string
    scope               = string
    metric_name         = string
    threshold           = number
    severity            = number
    frequency           = string
    window_size         = string
    action_group_ids    = list(string)
  }))
}