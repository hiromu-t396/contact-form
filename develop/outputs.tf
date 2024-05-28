output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
}

output "primary_web_endpoint" {
  value = azurerm_storage_account.storage_account.primary_web_host
}

output "cdn_endpoint" {
  value = azurerm_cdn_endpoint.endpoint.name
}
