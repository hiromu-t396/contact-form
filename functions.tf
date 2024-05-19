resource "azurerm_service_plan" "aps" {
  name                = "functions-aps"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Windows"
  sku_name            = "B1"
}

resource "azurerm_windows_function_app" "functions" {
  name                = "${local.project}-functions"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.aps.id

  storage_account_name       = azurerm_storage_account.functions.name
  storage_account_access_key = azurerm_storage_account.functions.primary_access_key

  site_config {
    application_stack {
      powershell_core_version = "7"
    }
  }
}

resource "azurerm_function_app_function" "function" {
  name            = "${local.project}"
  function_app_id = azurerm_windows_function_app.functions.id
  language        = "PowerShell"

    file {
    name    = "run.ps1"
    content = file("${path.module}/run.ps1")
  }

  config_json = jsonencode({
    "bindings": [
    {
      "authLevel": "anonymous",
      "type": "httpTrigger",
      "direction": "in",
      "name": "Request",
      "methods": [
        "post"
      ]
    },
    {
      "type": "http",
      "direction": "out",
      "name": "Response"
    },
    {
      "name": "outputTable",
      "direction": "out",
      "type": "table",
      "tableName": "inquiry",
      "methods": [],
      "connection": "AzureWebJobsStorage"
    }
  ],
  "disabled": false
  })
}