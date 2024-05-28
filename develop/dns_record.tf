# サブドメインの切り出し
resource "azurerm_dns_cname_record" "cname" {
  name                = "www"
  zone_name           = azurerm_dns_zone.dns.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 3600
#   record              = "contact-form-endpoint.azureedge.net"
  record = "${data.terraform_remote_state.root.outputs.azurerm_cdn_endpoint.endpoint.name}.azureedge.net"
}
