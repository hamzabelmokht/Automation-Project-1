variable "location" {
  default = "canadacentral"
  type        = string
}

variable "resource_group_name" {
  default = "RG-01649543"
  type        = string
}

variable "vm_ids" {
  type        = list(string)
  default     = [] 
}