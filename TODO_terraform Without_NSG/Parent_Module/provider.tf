terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.28.0"
    }
  }
}

provider "azurerm" {
  features {}
    subscription_id = "ba3dd1c9-2ade-4648-a13f-65581e2a2874"
    
  }
