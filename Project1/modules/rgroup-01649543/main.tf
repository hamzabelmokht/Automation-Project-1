resource "azurerm_resource_group" "project_rg" {
  name     = var.rg_name
  location = var.location
}
