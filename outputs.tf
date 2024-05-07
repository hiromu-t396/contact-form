output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "primary_web_endpoint" {
  value = azurerm_storage_account.storage.primary_web_host
}