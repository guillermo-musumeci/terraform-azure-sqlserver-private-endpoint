#########################
## Network - Variables ##
#########################

variable "kopi-vnet-cidr" {
  type        = string
  description = "The CIDR of the VNET"
}

variable "kopi-db-subnet-cidr" {
  type        = string
  description = "The CIDR for the Backoffice subnet"
}

variable "kopi-private-dns" {
  type        = string
  description = "The private DNS name"
}

variable "kopi-dns-privatelink" {
  type        = string
  description = "SQL DNS Private Link"
}
