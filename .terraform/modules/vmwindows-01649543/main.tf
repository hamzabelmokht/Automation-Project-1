resource "azurerm_network_interface" "vmnic" {
  count               = 1
  name                = "vmnic-${var.dns_label}-nic-01649543"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vmwindows" {
  count                = 1
  name                 = "vmwindows-${var.dns_label}-01649543"
  location             = var.location
  resource_group_name  = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vmnic[0].id]
  size                 = "Standard_B1ms"
  admin_username       = "adminuser"
  admin_password       = "Password1234!" 

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  boot_diagnostics {
    storage_account_uri = module.common.azurerm_storage_account.bootdiag_sa.primary_blob_endpoint
  }

  provisioner "remote-exec" {
    inline = [
      "hostname",
      "ipconfig",
    ]
  }
}

resource "azurerm_virtual_machine_extension" "antimalware_extension" {
  count                = 1
  name                 = "AntimalwareExtension"
  virtual_machine_id   = module.vmwindows.azurerm_windows_virtual_machine.vmwindows[0].id
  publisher            = "Microsoft.Azure.Security"
  type                 = "IaaSAntimalware"
  type_handler_version = "1.0"

  settings = <<SETTINGS
    {
      "AntimalwareEnabled": true
    }
SETTINGS
}