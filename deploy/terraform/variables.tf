variable "environment" {
  description   = "Name of the environment (e.g. Dev, Prod)"
  type          = string
  default       = "prod"
}

variable "location" {
  description   = "Azure region for resources"
  type          = string
  default       = "eastus"
}
