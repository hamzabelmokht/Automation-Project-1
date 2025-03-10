resource "azurerm_postgresql_server" "postgresql" {
  name                         = "pg-server-${random_id.server_id.hex}"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  sku_name                     = var.sku_name
  storage_mb                   = var.storage_mb
  version                      = var.db_version
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  ssl_enforcement_enabled      = true
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
}

resource "azurerm_postgresql_database" "postgresql_db" {
  name                = var.db_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.postgresql.name
  charset             = var.charset
  collation           = var.collation
}


resource "random_id" "server_id" {
  byte_length = 8
}
