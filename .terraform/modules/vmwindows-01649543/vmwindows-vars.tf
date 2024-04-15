variable "location" {
  default = "canadacentral"
  type        = string
}

variable "resource_group_name" {
  default = "RG-01649543"
  type        = string
}


variable "dns_label" {
  description = "my-windows-DNS"
  type        = string
}

variable "storage_account_name" {
  type        = string
  default     = "sa01649543"
}

variable "subnet_id" {
  type        = string
}