########################
## Network - Endpoint ##
########################

# Create a DB Private Endpoint
resource "azurerm_private_endpoint" "kopi-db-endpoint" {
  depends_on = [azurerm_mssql_server.kopi-sql-server]

  name                = "${var.prefix}-${var.environment}-${var.app_name}-db-endpoint"
  location            = azurerm_resource_group.kopi-rg.location
  resource_group_name = azurerm_resource_group.kopi-rg.name
  subnet_id           = azurerm_subnet.kopi-db-subnet.id

  private_service_connection {
    name                           = "${var.prefix}-${var.environment}-${var.app_name}-db-endpoint"
    is_manual_connection           = "false"
    private_connection_resource_id = azurerm_mssql_server.kopi-sql-server.id
    subresource_names              = ["sqlServer"]
  }
}

# DB Private Endpoint Connecton
data "azurerm_private_endpoint_connection" "kopi-endpoint-connection" {
  depends_on = [azurerm_private_endpoint.kopi-db-endpoint]

  name                = azurerm_private_endpoint.kopi-db-endpoint.name
  resource_group_name = azurerm_resource_group.kopi-rg.name
}

# Create a DB Private DNS A Record
resource "azurerm_private_dns_a_record" "kopi-endpoint-dns-a-record" {
  depends_on = [azurerm_mssql_server.kopi-sql-server]

  name                = lower(azurerm_mssql_server.kopi-sql-server.name)
  zone_name           = azurerm_private_dns_zone.kopi-endpoint-dns-private-zone.name
  resource_group_name = azurerm_resource_group.kopi-rg.name
  ttl                 = 300
  records             = [data.azurerm_private_endpoint_connection.kopi-endpoint-connection.private_service_connection.0.private_ip_address]
}

# Create a Private DNS to VNET link
resource "azurerm_private_dns_zone_virtual_network_link" "dns-zone-to-vnet-link" {
  name                  = "${var.prefix}-${var.environment}-${var.app_name}-db-vnet-link"
  resource_group_name   = azurerm_resource_group.kopi-rg.name
  private_dns_zone_name = azurerm_private_dns_zone.kopi-endpoint-dns-private-zone.name
  virtual_network_id    = azurerm_virtual_network.kopi-vnet.id
}
