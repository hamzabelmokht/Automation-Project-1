resource "azurerm_managed_disk" "datadisk" {
  count                = 4
  name                 = "datadisk-${count.index + 1}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}
resource "azurerm_virtual_machine_data_disk_attachment" "vm_data_disk_attachment" {
  count              = 4
  virtual_machine_id = var.virtual_machine_ids[count.index]
  managed_disk_id    = azurerm_managed_disk.datadisk[count.index].id
  lun                = count.index
  caching            = "ReadWrite"
}