resource "azurerm_managed_disk" "datadisk" {
  count                = var.vm_count * 4
  name                 = "datadisk-${var.resource_group_name}-${count.index + 1}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "datadisk_attachment" {
  count               = var.vm_count * 4
  managed_disk_id     = module.datadisk.azurerm_managed_disk.datadisk[count.index].id
  virtual_machine_id  = var.vm_os_type == "linux" ? module.vmlinux.azurerm_linux_virtual_machine.vmlinux[count.index % var.vm_count].id : module.vmwindows.azurerm_windows_virtual_machine.vmwindows[count.index % var.vm_count].id
  lun                 = count.index
  caching             = "ReadWrite" 
}