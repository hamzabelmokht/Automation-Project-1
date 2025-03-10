resource "azurerm_availability_set" "vm_avset" {
  name                        = "vmlinux-availabilityset"
  location                    = var.location
  resource_group_name         = var.rg_name
  platform_fault_domain_count = 2
}

resource "azurerm_public_ip" "vm_pip" {
  for_each            = var.vm_names
  name                = "${each.value}-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  domain_name_label   = "vm-${each.key}"
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.vm_names
  name                = "${each.value}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_pip[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each              = var.vm_names
  name                  = each.value
  location              = var.location
  resource_group_name   = var.rg_name
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]
  availability_set_id   = azurerm_availability_set.vm_avset.id

  os_disk {
    name                 = "${each.value}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "8.2.2020111800"
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  depends_on = [
    azurerm_public_ip.vm_pip
  ]
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each             = var.vm_names
  name                 = "NetworkWatcherAgentLinux-${each.value}"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm[each.key].id
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"

  depends_on = [
    azurerm_linux_virtual_machine.vm
  ]
}

/* resource "azurerm_virtual_machine_extension" "azure_monitor" {
  for_each             = var.vm_names
  name                 = "AzureMonitorLinuxAgent-${each.value}"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm[each.key].id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.0" #this is the specifc line causing error tried 10 separate versions wasnt able to resolve. 
} */
