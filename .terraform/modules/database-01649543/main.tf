resource "azurerm_postgresql_server" "database" {
  name                = var.database_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  version             = var.postgresql_version

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  ssl_enforcement_enabled = true  

  tags = var.tags
}

resource "azurerm_postgresql_storage_account" "database_storage" {
  server_name         = azurerm_postgresql_server.database.name
  resource_group_name = azurerm_postgresql_server.database.resource_group_name

  storage_mb            = var.storage_mb
  backup_retention_days = var.backup_retention_days
  geo_redundant_backup  = var.geo_redundant_backup
}