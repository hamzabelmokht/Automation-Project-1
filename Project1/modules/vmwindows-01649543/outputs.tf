output "hostname" {
  value = azurerm_windows_virtual_machine.windows_vm[*].name
}

output "domain_name" {
  value = azurerm_public_ip.windows_public_ip[*].fqdn
}

output "private_ip_address" {
  value = azurerm_network_interface.windows_nic[*].ip_configuration[*].private_ip_address
}

output "public_ip_address" {
  value = azurerm_public_ip.windows_public_ip[*].ip_address
}

output "vm_id" {
  value = azurerm_windows_virtual_machine.windows_vm[0].id
}