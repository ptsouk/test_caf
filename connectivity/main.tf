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

module "alz_connectivity" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "4.0.2"
  
  # this list of providers is expected by the module and must be left as is
  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  # Base module configuration settings
  root_parent_id   = module.settings.default.tenant_id
  root_id          = module.settings.default.root_id
  root_name        = module.settings.default.root_name
  default_location = module.settings.default.primary_location
  default_tags     = module.settings.shared.default_tags

  strict_subscription_association = false
  
  # Configuration settings for core resources
  deploy_core_landing_zones = false

  # Configuration settings for connectivity resources
  deploy_connectivity_resources    = true
  configure_connectivity_resources = var.configure_connectivity_resources
  subscription_id_connectivity     = var.subscription_id_connectivity
}
