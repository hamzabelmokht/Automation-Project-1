variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "B_Gen5_1"
}

variable "storage_mb" {
  type    = number
  default = 5120
}

variable "db_version" {
  type    = string
  default = "11"
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "backup_retention_days" {
  type    = number
  default = 7
}

variable "geo_redundant_backup_enabled" {
  type    = bool
  default = false
}

variable "db_name" {
  type = string
}

variable "charset" {
  type    = string
  default = "UTF8"
}

variable "collation" {
  type    = string
  default = "en_US.utf8"
}
