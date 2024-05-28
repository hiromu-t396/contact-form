terraform {
  required_version = "1.8.0"
  # tfstate用のリソースグループ、ストレージアカウントは手動で作成
  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "contactformfortfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.100.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
