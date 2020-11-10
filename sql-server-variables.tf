############################
## SQL Server - Variables ##
############################

variable "kopi-sql-admin-username" {
  description = "Username for SQL Server administrator account"
  type        = string
  default     = "sqladmin"
}

variable "kopi-sql-admin-password" {
  description = "Password for SQL Server administrator account"
  type        = string
  default     = "S3cur3Acc3ss67"
}

