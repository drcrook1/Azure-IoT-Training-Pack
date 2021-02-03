provider "azurerm" {
    version = "=2.1.0"
    features {}
}

resource "azurerm_resource_group" "rg" {
  name      = "azmonitor-${var.environment}"
  location  = var.location
}

resource "azurerm_app_service_plan" "asp" {
  name                = "azmonitor-asp-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "apps" {
  name                = "azmonitor-app-service-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
    always_on                = true
  }

  app_settings = {
    "SOME_KEY" = "some-value"
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.appinsights.instrumentation_key
    "Database" = "Server=tcp:${azurerm_sql_server.sqlserver.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_sql_database.sqldb.name};Persist Security Info=False;User ID=${var.sqluser};Password=${var.sqlpassword};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }
}