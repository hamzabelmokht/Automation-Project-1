output "vm_info" {
  value = {
    for vm_name, vm in azurerm_linux_virtual_machine.vmlinux : vm_name => {
      hostname      = vm.name
      domain_name   = "${vm.name}.${azurerm_dns_zone.main.name}"
      private_ip    = vm.private_ip_address
      public_ip     = vm.public_ip_address
    }
  }
}

