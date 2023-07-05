terraform {
  required_version = ">= 1.3.1"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.29.1"
    }
  }
  backend "azurerm" {
    subscription_id      = "8ec43e9c-d13a-4219-a0d5-43292d705a78"
    tenant_id            = "f6279e07-c6ac-45ee-a551-12a2fdf33d14"
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatesta"
    container_name       = "tfstatecore"
    key                  = "terraform.tfstate"
  }
}
