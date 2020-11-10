######################
## Network - Output ##
######################

output "sql_private_link_endpoint_ip" {
  value = data.azurerm_private_endpoint_connection.kopi-endpoint-connection.private_service_connection.0.private_ip_address
}
