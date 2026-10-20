
variable "resource_groups" {
  description = "Azure Resource Group configurations"

  type = map(object({
    location = string
  }))
}

variable "storage_accounts" {
  description = "Azure Storage Account configurations"

  type = map(object({
    name               = string
    resource_group_key = string
    account_tier       = string
    replication_type   = string
  }))
}

variable "monitoring_workspaces" {
  description = "Log Analytics Workspace configurations"

  type = map(object({
    name               = string
    resource_group_key = string
    retention_in_days  = number
  }))
}

variable "metric_alerts" {
  description = "Azure Monitor metric alert configurations"

  type = map(object({
    name                = string
    resource_group_key  = string
    storage_account_key = string
    metric_name         = string
    threshold           = number
    severity            = number
    frequency           = string
    window_size         = string
    action_group_key    = string
  }))
}

variable "action_groups" {
  description = "Action Group configurations"

  type = map(object({
    name          = string
    short_name    = string
    email_name    = string
    email_address = string

  }))
}