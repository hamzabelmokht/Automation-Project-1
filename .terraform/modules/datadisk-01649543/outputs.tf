output "datadisk_ids" {
  value       = module.datadisk.azurerm_managed_disk.datadisk[*].id
}