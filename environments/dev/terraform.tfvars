resource_groups = {
  aiops_dev = {
    location = "Central India"
  }

  aiops_monitoring = {
    location = "West India"
  }
}

storage_accounts = {
  metrics = {
    name               = "aiopsmetricsdev001"
    resource_group_key = "aiops_dev"
    account_tier       = "Standard"
    replication_type   = "LRS"
  }
}

monitoring_workspaces = {
  primary = {
    name               = "aiops-mlops-law-dev"
    resource_group_key = "aiops_monitoring"
    retention_in_days  = 30
  }
}

metric_alerts = {
  storage_transactions = {
    name                = "aiops-storage-transaction-alert"
    resource_group_key  = "aiops_monitoring"
    storage_account_key = "metrics"

    metric_name = "Transactions"
    threshold   = 1000
    severity    = 2

    frequency        = "PT1M"
    window_size      = "PT5M"
    action_group_key = "operations"
  }
}

action_groups = {
  operations = {
    name          = "aiops-operations-ag"
    short_name    = "aiopsops"
    email_name    = "operations-alert"
    email_address = "bb7943239@gmail.com"
  }
}  