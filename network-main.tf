####################
## Network - Main ##
####################

# Create a resource group
resource "azurerm_resource_group" "kopi-rg" {
  name     = "${var.prefix}-${var.environment}-${var.app_name}-rg"
  location = var.location

  tags = {
    environment = var.environment
  }
}

# Create the VNET
resource "azurerm_virtual_network" "kopi-vnet" {
  name                = "${var.prefix}-${var.environment}-${var.app_name}-vnet"
  address_space       = [var.kopi-vnet-cidr]
  location            = azurerm_resource_group.kopi-rg.location
  resource_group_name = azurerm_resource_group.kopi-rg.name

  tags = {
    environment = var.environment
  }
}

# Create a DB subnet
resource "azurerm_subnet" "kopi-db-subnet" {
  name                 = "${var.prefix}-${var.environment}-${var.app_name}-db-subnet"
  address_prefixes     = [var.kopi-db-subnet-cidr]
  virtual_network_name = azurerm_virtual_network.kopi-vnet.name
  resource_group_name  = azurerm_resource_group.kopi-rg.name

  enforce_private_link_endpoint_network_policies = true
}

