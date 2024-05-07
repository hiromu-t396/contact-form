resource "azurerm_cdn_profile" "cdn" {
  name                = "contact-form"
  location            = "Global"
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_Verizon"
}

resource "azurerm_cdn_endpoint" "endpoint" {
  name                = "contact-form-endpoint"
  profile_name        = azurerm_cdn_profile.cdn.name
  location            = "Global"
  resource_group_name = azurerm_resource_group.rg.name

  origin {
    name      = "forstatic-blob-container"
    host_name = "forstaticfile.blob.core.windows.net"
  }
}

resource "azurerm_cdn_endpoint_custom_domain" "cdn_custom_domain" {
  name            = "test"
  cdn_endpoint_id = azurerm_cdn_endpoint.endpoint.id
  host_name       = "${azurerm_dns_cname_record.cname.name}.${azurerm_dns_zone.dns.name}"
  
cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
    tls_version      = "TLS12"
  }
}