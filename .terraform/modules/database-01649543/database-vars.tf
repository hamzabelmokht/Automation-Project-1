variable "database_name" {
  description = "The name of the PostgreSQL database instance"
  type        = string
}

variable "location" {
  default = "canadacentral"
  type        = string
}

variable "resource_group_name" {
  default = "RG-01649543"
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the PostgreSQL database instance"
  type        = string
}

variable "postgresql_version" {
  description = "The version of PostgreSQL to use for the database instance"
  type        = string
}

variable "administrator_login" {
    type        = string
    default      = "admin"
}

variable "administrator_login_password" {
    type        = string
    default      = "root"
}

variable "storage_mb" {
  type        = number
  default     = 2048
}

variable "backup_retention_days" {
  type        = number
  default     = 1
}

variable "geo_redundant_backup" {
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to apply to the PostgreSQL server"
  type        = map(string)
  default = {
    environment = "Development"
    owner       = "Hamza"
    project     = "Project 2"
  }
}