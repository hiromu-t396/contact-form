resource "azurerm_storage_account" "storage" {
  name                     = "forstaticfile"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  static_website {
    index_document = "index.html"
    error_404_document = "error.html"
  }
   custom_domain {
    name         = "www.forpoc.com"  # ここにカスタムドメイン名を指定します
    use_subdomain = false          # サブドメインを使用する場合は true を指定します
  }
}

resource "azurerm_storage_blob" "html" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "index.html"
}

resource "azurerm_storage_blob" "css" {
  name                   = "style.css"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/css"
  source                 = "style.css"
}