# サブドメインの切り出し
resource "azurerm_dns_cname_record" "cname" {
  name                = "www"
  zone_name           = data.terraform_remote_state.root.outputs.azurerm_dns_zone
  resource_group_name = data.terraform_remote_state.root.outputs.resource_group_name
  ttl                 = 3600
  record              = "contact-form-endpoint.azureedge.net"
}
