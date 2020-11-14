#########################
## SQL Server - Output ##
#########################

output "sql_db" {
  description = "SQL Server DB and Database"
  value       = "${azurerm_sql_database.kopi-sql-db.server_name}/${azurerm_sql_database.kopi-sql-db.name}"
}
