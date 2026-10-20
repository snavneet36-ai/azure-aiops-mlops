module "resource_group" {
  source = "../../modules/resource-group"

  resource_groups = var.resource_groups
}

module "storage" {
  source = "../../modules/storage"

  storage_accounts = {
    for key, account in var.storage_accounts :
    key => {
      name                = account.name
      resource_group_name = module.resource_group.resource_group_names[account.resource_group_key]
      location            = var.resource_groups[account.resource_group_key].location
      account_tier        = account.account_tier
      replication_type    = account.replication_type
    }
  }
}

module "monitoring" {
  source = "../../modules/monitoring"

  monitoring_workspaces = {
    for key, workspace in var.monitoring_workspaces :
    key => {
      name                = workspace.name
      resource_group_name = module.resource_group.resource_group_names[workspace.resource_group_key]
      location            = var.resource_groups[workspace.resource_group_key].location
      retention_in_days   = workspace.retention_in_days
    }
  }
}

module "monitor_alert" {
  source = "../../modules/monitor-alert"

  metric_alerts = {
    for key, alert in var.metric_alerts :
    key => {
      name = alert.name

      resource_group_name = module.resource_group.resource_group_names[
        alert.resource_group_key
      ]

      scope = module.storage.storage_account_ids[
        alert.storage_account_key
      ]

      metric_name = alert.metric_name
      threshold   = alert.threshold
      severity    = alert.severity
      frequency   = alert.frequency
      window_size = alert.window_size

      action_group_ids = [
        module.action_group.action_group_ids[alert.action_group_key]
      ]
    }
  }
}

module "action_group" {
  source = "../../modules/action-group"

  action_groups = {
    for key, group in var.action_groups :
    key => {
      name                = group.name
      resource_group_name = module.resource_group.resource_group_names["aiops_monitoring"]
      short_name          = group.short_name
      email_name          = group.email_name
      email_address       = group.email_address
    }
  }
}