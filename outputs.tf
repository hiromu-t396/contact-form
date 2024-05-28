output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "azurerm_dns_zone" {
  value = azurerm_dns_zone.main.name
}
