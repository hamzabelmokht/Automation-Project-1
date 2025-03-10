terraform {
  backend "azurerm" {
    resource_group_name  = "n01649543-rg"
    storage_account_name = "01649543storageacc"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}

