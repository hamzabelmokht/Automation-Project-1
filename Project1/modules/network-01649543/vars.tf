variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnet_address_prefix" {
  type = list(string)
}