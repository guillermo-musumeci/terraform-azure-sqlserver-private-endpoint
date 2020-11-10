###################
## Network - DNS ##
###################

# Create a Private DNS Zone
resource "azurerm_private_dns_zone" "kopi-private-dns" {
  name                = var.kopi-private-dns
  resource_group_name = azurerm_resource_group.kopi-rg.name
}

# Link the Private DNS Zone with the VNET
resource "azurerm_private_dns_zone_virtual_network_link" "kopi-private-dns-link" {
  name                  = "${var.prefix}-${var.environment}-${var.app_name}-vnet"
  resource_group_name   = azurerm_resource_group.kopi-rg.name
  private_dns_zone_name = azurerm_private_dns_zone.kopi-private-dns.name
  virtual_network_id    = azurerm_virtual_network.kopi-vnet.id
}

# Create a DB Private DNS Zone
resource "azurerm_private_dns_zone" "kopi-endpoint-dns-private-zone" {
  name                = "${var.kopi-dns-privatelink}.database.windows.net"
  resource_group_name = azurerm_resource_group.kopi-rg.name
}
