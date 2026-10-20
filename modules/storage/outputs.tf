output "storage_account_names" {
  description = "Names of created Storage Accounts"

  value = {
    for key, account in azurerm_storage_account.SA :
    key => account.name
  }
}

output "storage_account_ids" {
  description = "IDs of created Storage Accounts"

  value = {
    for key, account in azurerm_storage_account.SA :
    key => account.id
  }
}