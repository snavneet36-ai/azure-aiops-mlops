output "resource_group_names" {
  description = "Created Resource Group names"

  value = {
    for key, rg in azurerm_resource_group.this :
    key => rg.name
  }
}
