resource "azurerm_resource_group" "rg" {
  name     = "${local.project_name}-rg"
  location = local.location
}
