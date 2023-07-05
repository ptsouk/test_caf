terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.29.1"
    } 
  }
}

module "settings" {
  source = "../settings"
}

module "lz_vending" {
  source   = "Azure/lz-vending/azurerm"
  version  = "2.1.1" # change this to your desired version, https://www.terraform.io/language/expressions/version-constraints

  location = var.location

  # subscription variables
  subscription_id = var.subscription_id
  # subscription_alias_enabled = true
  # subscription_billing_scope = var.subscription_billing_scope
  # subscription_display_name  = var.subscription_display_name
  # subscription_alias_name    = var.subscription_alias_name
  # subscription_workload      = var.subscription_workload

  # management group association variables
  subscription_management_group_association_enabled = var.subscription_management_group_association_enabled
  subscription_management_group_id                  = var.management_group_id

  # virtual network variables
  virtual_network_enabled = true
  virtual_networks = {
    for k, v in var.virtual_networks : k => merge(
      v,
      {
        hub_network_resource_id         = var.hub_network_resource_id
        hub_peering_use_remote_gateways = false
      }
    )
  }
}