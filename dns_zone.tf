resource "azurerm_dns_zone" "main" {
  name                = "forpoc.com"
  resource_group_name = azurerm_resource_group.rg.name
}
