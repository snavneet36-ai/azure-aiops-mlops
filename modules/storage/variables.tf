variable "storage_accounts" {
  description = "Map of Azure Storage Account configurations"

  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    account_tier        = string
    replication_type    = string
  }))
}