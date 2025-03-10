resource "null_resource" "vm_provisioner" {
  for_each = var.vm_names

  provisioner "remote-exec" {
    inline = [
      "echo VM Hostname: $(hostname)"
    ]

    connection {
      type        = "ssh"
      host        = azurerm_linux_virtual_machine.vm[each.key].public_ip_address
      user        = var.admin_username
      private_key = file("~/.ssh/id_rsa")
    }
  }

  depends_on = [azurerm_linux_virtual_machine.vm]
}