resource "azurerm_virtual_network" "vnet" {
  name                = "01649543-vnet"
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.address_space
}

resource "azurerm_subnet" "subnet" {
  name                 = "01649543-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefix
}

resource "azurerm_network_security_group" "nsg" {
  name                = "01649543-nsg"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "allow_ssh"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    priority                   = 100
    source_port_range          = "*"
    destination_port_range     = 22
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_rdp"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    priority                   = 110
    source_port_range          = "*"
    destination_port_range     = 3389
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_winrm"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    priority                   = 120
    source_port_range          = "*"
    destination_port_range     = 5985
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_http"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    priority                   = 130
    source_port_range          = "*"
    destination_port_range     = 80
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}