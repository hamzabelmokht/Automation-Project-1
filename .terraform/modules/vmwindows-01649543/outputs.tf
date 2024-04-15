output "hostname" {
  value = azurerm_windows_virtual_machine.vmwindows[0].private_ip_address
}

output "domain_name" {
  value = azurerm_windows_virtual_machine.vmwindows[0].private_ip_address
}

output "private_ip_address" {
  value = azurerm_windows_virtual_machine.vmwindows[0].private_ip_address
}

output "public_ip_address" {
  value = azurerm_windows_virtual_machine.vmwindows[0].public_ip_address
}