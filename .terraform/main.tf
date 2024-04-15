module "rgroup" {
  source = "./modules/rgroup-01649543"
}

module "network" {
  source              = "./modules/network-01649543"
  resource_group_name = module.rgroup.resource_group_name
  location            = module.rgroup.location
}

module "common" {
  source              = "./modules/common-01649543"
  location            = module.rgroup.location
  resource_group_name = module.rgroup.resource_group_name
}

module "vmwindows" {
  source                 = "./modules/vmwindows-01649543"
  resource_group_name    = module.rgroup.resource_group_name
  location               = module.rgroup.location
  subnet_id              = module.network.azurerm_subnet.SUBNET.id
  dns_label              = "my-windows-vm"
}

module "datadisk" {
  source              = "./modules/datadisk-01649543"
  vm_count            = module.vmwindows.vm_count
  vm_os_type          = module.datadisk.vm_os_type
  vm_names            = module.datadisk.vm_names
}

module "loadbalancer" {
  source              = "./modules/loadbalancer-01649543"
  resource_group_name = module.rgroup.resource_group_name
  location            = module.rgroup.location
  vm_ids              = module.vmlinux.vm_ids  
}

module "database" {
  source              = "./modules/database-01649543"
  resource_group_name = module.database.resource_group_name
  location            = module.rgroup.location
  database_name       = module.database.database_name
  sku_name            = module.database.sku_name
  postgresql_version  = module.database.postgresql_version
  administrator_login = module.database.administrator_login
  administrator_login_password = module.database.administrator_login_password
  storage_mb          = module.database.storage_mb
  backup_retention_days = module.database.backup_retention_days
  geo_redundant_backup  = module.database.geo_redundant_backup
  tags                = module.database.tags
}

