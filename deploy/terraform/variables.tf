variable "environment" {
  description   = "Name of the environment (e.g. Dev, Prod)"
  default       = "prod"
}

variable "location" {
  description   = "Azure region for resources"
  default       = "eastus"
}
