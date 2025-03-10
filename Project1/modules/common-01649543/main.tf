resource "azurerm_log_analytics_workspace" "workspace" {
  name                = "01649543-workspace"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
}

resource "azurerm_recovery_services_vault" "service_vault" {
  name                = "n01649543-service-vault"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "01649543storageacc"
  location                 = var.location
  resource_group_name      = var.rg_name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [azurerm_log_analytics_workspace.workspace, azurerm_recovery_services_vault.service_vault]
}


