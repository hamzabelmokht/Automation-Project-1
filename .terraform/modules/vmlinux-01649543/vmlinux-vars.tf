variable "location" {
  default = "canadacentral"
  type        = string
}

variable "resource_group_name" {
  default = "RG-01649543"
  type        = string
}

variable "extensions" {
  type        = map(object({
    name                 = string
    publisher            = string
    type                 = string
    type_handler_version = string
  }))
  default = {
    "vm1" = {
      name                 = "NetworkWatcherAgentLinux"
      publisher            = "Microsoft.Azure.NetworkWatcher"
      type                 = "NetworkWatcherAgentLinux"
      type_handler_version = "1.0"
    },
    "vm2" = {
      name                 = "AzureMonitorLinuxAgent"
      publisher            = "Microsoft.Azure.Monitor"
      type                 = "AzureMonitorLinuxAgent"
      type_handler_version = "1.0"
    },
    "vm3" = {
      name                 = "Extension3"
      publisher            = "Publisher3"
      type                 = "Type3"
      type_handler_version = "1.0"
    }
  }
}

variable "storage_account_name" {
  type        = string
  default     = "sa01649543"
}

variable "availability_set_name" {
  type        = string
  default     = "my-availability-set"
}

variable "vm_dns_labels" {
  type        = map(string)
  default     = {
    "vm1" = "vm1-dns-label"
    "vm2" = "vm2-dns-label"
    "vm3" = "vm3-dns-label"
  }
}

variable "vm_ids" {
  type        = list(string)
}