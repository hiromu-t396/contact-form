resource "azurerm_resource_group" "rg" {
  name     = "${local.project}-rg"
  location = local.location
}
