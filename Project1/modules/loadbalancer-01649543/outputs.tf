output "load_balancer_name" {
  value = azurerm_lb.lb.name
}

output "load_balancer_public_ip" {
  value = azurerm_public_ip.lb_public_ip.ip_address
}