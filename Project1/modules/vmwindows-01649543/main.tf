resource "azurerm_availability_set" "vm_availability_set" {
  name                         = "availability-set"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  count               = 1
  name                = "w-vm${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  availability_set_id = azurerm_availability_set.vm_availability_set.id
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.windows_nic[count.index].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

}

resource "azurerm_virtual_machine_extension" "antimalware" {
  count                      = 1
  name                       = "MicrosoftAntimalware-w-vm${count.index + 1}"
  virtual_machine_id         = azurerm_windows_virtual_machine.windows_vm[count.index].id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.5"
  auto_upgrade_minor_version = true
}

resource "azurerm_network_interface" "windows_nic" {
  count               = 1
  name                = "windows-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows_public_ip[count.index].id
  }
}

resource "azurerm_public_ip" "windows_public_ip" {
  count               = 1
  name                = "windows-pip-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = "w-vm${count.index + 1}"
  sku                 = "Standard"
}
