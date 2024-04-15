resource "azurerm_linux_virtual_machine" "vmlinux" {
  for_each                = var.vm_dns_labels
  name                    = "vm-${each.key}-01649543"
  resource_group_name     = var.resource_group_name
  location                = var.location
  size                    = "Standard_B1ms"
  admin_username          = "adminuser"
  disable_password_authentication = true
  network_interface_ids   = [azurerm_network_interface.vmnic[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  boot_diagnostics {
    storage_account_uri  = module.common.azurerm_storage_account.bootdiag_sa.primary_blob_endpoint
  }

  provisioner "null_resource" {
    connection {
      type        = "ssh"
      host        = self.public_ip_address
      user        = self.admin_username
      private_key = file("~/.ssh/terraform_rsa") 
    }

    provisioner "local-exec" {
      command = "echo ${self.name} ${self.private_ip_address} ${self.public_ip_address} ${self.dns_label} >> vm_info.txt"
    }
  }

  dynamic "extension" {
    for_each = var.extensions

    content {
      name                  = extension.value.name
      publisher             = extension.value.publisher
      type                  = extension.value.type
      type_handler_version  = extension.value.type_handler_version
    }
  }

  tags = {
    lb_candidate = true
  }
}