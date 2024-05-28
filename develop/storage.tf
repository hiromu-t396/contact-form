# 静的ファイル保管用
resource "azurerm_storage_account" "storage_account" {
  name                     = "forpoc"
  resource_group_name      = data.terraform_remote_state.root.outputs.resource_group_name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "storage_container" {
  name                  = "web"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "blob"
}
resource "azurerm_storage_blob" "html" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.storage_container.name
  type                   = "Block"
  content_type           = "text/html"
  source                 = "index.html"
}
resource "azurerm_storage_blob" "css" {
  name                   = "style.css"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.storage_container.name
  type                   = "Block"
  content_type           = "text/css"
  source                 = "style.css"
}

# Azure Functions用
resource "azurerm_storage_account" "functions" {
  name                     = replace("${local.env}${local.project_name}", "-", "")
  resource_group_name      = data.terraform_remote_state.root.outputs.resource_group_name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

#POSTデータ格納用
resource "azurerm_storage_table" "table" {
  name                 = "inquiry"
  storage_account_name = azurerm_storage_account.functions.name
}
