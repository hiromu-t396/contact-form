resource "azurerm_cdn_profile" "cdn" {
  name                = "forpoc"
  location            = "Global"
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "endpoint" {
  name                = "contact-form-endpoint"
  profile_name        = azurerm_cdn_profile.cdn.name
  location            = "Global"
  resource_group_name = azurerm_resource_group.rg.name
  is_http_allowed     = "false"
  origin_path         = "/web"
  origin_host_header  = azurerm_storage_account.storage_account.primary_blob_host
  origin {
    name      = "forpoc"
    host_name  = azurerm_storage_account.storage_account.primary_blob_host
  }
  ///HTTPからHTTPSへのリダイレクト設定
  delivery_rule {
    name  = "EnforceHTTPS"
    order = "1"
    request_scheme_condition {
      operator     = "Equal"
      match_values = ["HTTP"]
    }
    url_redirect_action {
      redirect_type = "Found"
      protocol      = "Https"
    }
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
  lifecycle {
    ignore_changes = [
      cdn_managed_https
    ]
  }
}