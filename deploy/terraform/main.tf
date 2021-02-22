terraform {
  required_version = ">= 0.14"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.46.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "ftaiot-${var.environment}"
  location = var.location
}
