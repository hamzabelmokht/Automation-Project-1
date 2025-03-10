module "project_rg" {
  source   = "./modules/rgroup-01649543"
  rg_name  = "n01649543-rg"
  location = "East US"
}

module "network-01649543" {
  source                = "./modules/network-01649543"
  rg_name               = module.project_rg.project_rg_name
  location              = "East US"
  address_space         = ["10.0.0.0/16"]
  subnet_address_prefix = ["10.0.1.0/24"]
}

module "common-01649543" {
  source   = "./modules/common-01649543"
  location = "East US"
  rg_name  = module.project_rg.project_rg_name
}

module "vmlinux" {
  source              = "./modules/vmlinux-01649543"
  location            = "East US"
  rg_name             = module.project_rg.project_rg_name
  subnet_id           = module.network-01649543.subnet_id
  storage_account_uri = module.common-01649543.storage_account_uri
  linux_vm_name       = "01649543-linuxvm"
  vm_names            = ["vm1", "vm2", "vm3"]
  vm_size             = "Standard_D2s_v3"
  admin_username      = "adminuser"
  admin_password      = "Password123!"

}

module "vmwindows_01649543" {
  source              = "./modules/vmwindows-01649543"
  location            = "East US"
  resource_group_name = module.project_rg.project_rg_name
  admin_username      = "adminuser"
  admin_password      = "Password123!"
  subnet_id           = module.network-01649543.subnet_id
  storage_account_uri = module.common-01649543.storage_account_uri
}

module "datadisk_01649543" {
  source              = "./modules/datadisk-01649543"
  location            = "East US"
  resource_group_name = module.project_rg.project_rg_name
  virtual_machine_ids = concat(module.vmlinux.vm_ids, [module.vmwindows_01649543.vm_id])
}

module "loadbalancer_01649543" {
  source              = "./modules/loadbalancer-01649543"
  location            = "East US"
  resource_group_name = module.project_rg.project_rg_name
  linux_vm_nic_ids    = module.vmlinux.vm_nic_ids
}

module "database" {
  source              = "./modules/database-01649543"
  location            = "East US"
  resource_group_name = module.project_rg.project_rg_name
  admin_username      = "adminuser"
  admin_password      = "Password123!"
  db_name             = "postgre-DB1"
}