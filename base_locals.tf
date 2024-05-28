locals {
  env ="root"
}

data "terraform_remote_state" "root" {
  backend = "azurerm"

  config = {
    resource_group_name  = local.state_file_resource_group_name
    storage_account_name = local.state_file_storage_account_name
    container_name       = local.state_file_storage_container_name
    key                  = local.root_state_file
  }
}
