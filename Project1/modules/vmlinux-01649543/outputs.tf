output "vm_hostnames" {
  value = [for vm in azurerm_linux_virtual_machine.vm : vm.name]
}

output "vm_domain_names" {
  value = [for pip in azurerm_public_ip.vm_pip : pip.fqdn]
}

output "vm_private_ips" {
  value = [for nic in azurerm_network_interface.nic : nic.private_ip_address]
}

output "vm_public_ips" {
  value = [for pip in azurerm_public_ip.vm_pip : pip.ip_address]
}

output "vm_ids" {
  value = [for vm in azurerm_linux_virtual_machine.vm : vm.id]
}

output "vm_nic_ids" {
  value = values(azurerm_network_interface.nic)[*].id
}
