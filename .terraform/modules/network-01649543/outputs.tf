output "virtual_network_name" {
  value = azurerm_virtual_network.VNET.name
}

output "subnet_name" {
  value = azurerm_subnet.SUBNET.name
}

output "subnet_id" {
  value = azurerm_subnet.SUBNET.id
}