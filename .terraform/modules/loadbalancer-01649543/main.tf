resource "azurerm_lb" "loadbalancer" {
  name                = "lb-01649543"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"

  frontend_ip_configuration {
    name                          = "PublicIPAddress"
    public_ip_address_id          = azurerm_public_ip.lb_public_ip.id
  }

  dynamic "backend_address_pool" {
    for_each = var.vm_ids
    content {
      name = "vm-pool"
      backend_ip_configurations {
        ip_configuration_id = each.value
      }
    }
  }
}

resource "azurerm_public_ip" "lb_public_ip" {
  name                = "lb-public-ip-01649543"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}