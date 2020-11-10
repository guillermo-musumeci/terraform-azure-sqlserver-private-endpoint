#######################
## SQL Server - Main ##
#######################

# Create the SQL Server 
resource "azurerm_mssql_server" "kopi-sql-server" {
  name                          = "${var.prefix}-${var.environment}-${var.app_name}-sql-server" # NOTE: needs to be globally unique
  resource_group_name           = azurerm_resource_group.kopi-rg.name
  location                      = azurerm_resource_group.kopi-rg.location
  version                       = "12.0"
  administrator_login           = var.kopi-sql-admin-username
  administrator_login_password  = var.kopi-sql-admin-password
  public_network_access_enabled = false

  tags = {
    environment = var.environment
  }
}

# Create a the SQL database 
resource "azurerm_sql_database" "kopi-sql-db" {
  depends_on = [azurerm_mssql_server.kopi-sql-server]

  name                = "kopi-db"
  resource_group_name = azurerm_resource_group.kopi-rg.name
  location            = azurerm_resource_group.kopi-rg.location
  server_name         = azurerm_mssql_server.kopi-sql-server.name
  edition             = "Standard"
  collation           = "Latin1_General_CI_AS"
  max_size_bytes      = "10737418240"
  zone_redundant      = false
  read_scale          = false

  tags = {
    environment = var.environment
  }
}

