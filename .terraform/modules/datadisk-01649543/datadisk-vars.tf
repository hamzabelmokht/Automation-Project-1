variable "location" {
  default = "canadacentral"
  type        = string
}

variable "vm_count" {
  default     = 4
  type        = number
}

variable "disk_size_gb" {
  default     = 10
  type        = number
}

variable "vm_os_type" {
  description = "Type of OS for the VMs"
  type        = list(string)
  default = ["linux", "windows"]
}

variable "resource_group_name" {
  default = "RG-01649543"
  type        = string
}

variable "vm_names" {
  type        = list(string)
  default = ["vm1-my-dns-label", "vm2-my-dns-label", "vm3-my-dns-label", "my-windows-my-dns-label"]
}
