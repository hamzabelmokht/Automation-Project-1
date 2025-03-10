variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "storage_account_uri" {
  type = string
}

variable "linux_vm_name" {
  type = string
}

variable "vm_names" {
  type    = set(string)
  default = ["vm1", "vm2", "vm3"]
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}
