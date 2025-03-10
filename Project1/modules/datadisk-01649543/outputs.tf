output "datadisk_ids" {
  value = azurerm_managed_disk.datadisk[*].id
}

output "data_disk_attachment_ids" {
  value = azurerm_virtual_machine_data_disk_attachment.vm_data_disk_attachment[*].id
}