resource "azurerm_dns_zone" "dns" {
  name                = "forpoc.com"
  resource_group_name = azurerm_resource_group.rg.name
}

# サブドメインの切り出し
resource "azurerm_dns_cname_record" "cname" {
  name                = "www"
  zone_name           = azurerm_dns_zone.dns.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 3600
  record              = "forstaticfile.z11.web.core.windows.net"
}