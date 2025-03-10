output "project_rg" {
  value = module.project_rg.project_rg_name
}

output "vnet_name" {
  value = module.network-01649543.vnet_name
}

output "subnet_name" {
  value = module.network-01649543.subnet_name
}

output "log_analytics_workspace_name" {
  value = module.common-01649543.log_analytics_workspace_name
}

output "recovery_services_vault_name" {
  value = module.common-01649543.recovery_services_vault_name
}

output "storage_account_name" {
  value = module.common-01649543.storage_account_name
}

output "linux_vm_hostnames" {
  value = module.vmlinux.vm_hostnames
}

output "linux_vm_domain_names" {
  value = module.vmlinux.vm_domain_names
}

output "linux_vm_private_ips" {
  value = module.vmlinux.vm_private_ips
}

output "linux_vm_public_ips" {
  value = module.vmlinux.vm_public_ips
}

output "vm_hostname" {
  value = module.vmwindows_01649543.hostname
}

output "vm_domain_name" {
  value = module.vmwindows_01649543.domain_name
}

output "vm_private_ip" {
  value = module.vmwindows_01649543.private_ip_address
}

output "vm_public_ip" {
  value = module.vmwindows_01649543.public_ip_address
}

output "datadisk_ids" {
  value = module.datadisk_01649543.datadisk_ids
}

output "data_disk_attachment_ids" {
  value = module.datadisk_01649543.data_disk_attachment_ids
}

output "load_balancer_name" {
  value = module.loadbalancer_01649543.load_balancer_name
}

output "load_balancer_public_ip" {
  value = module.loadbalancer_01649543.load_balancer_public_ip
}

output "database_name" {
  value = module.database.postgresql_database_name
}
