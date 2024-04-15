resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-01649543"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
}

resource "azurerm_recovery_services_vault" "rsv" {
  name                = "rsv-01649543"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
}

resource "azurerm_storage_account" "sa" {
  name                     = "sa01649543"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}