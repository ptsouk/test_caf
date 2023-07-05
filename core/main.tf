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

module "alz_core" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "4.0.2"

  # This list of providers is expected by the module and must be left as is
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

  # Configuration settings for optional landing zones
  deploy_corp_landing_zones   = true
  deploy_online_landing_zones = true
  deploy_sap_landing_zones    = false
  deploy_demo_landing_zones   = false

  # Configure path for custom library folder and
  # custom template file variables
  library_path            = "${path.root}/lib"
  template_file_variables = module.settings.core.custom_template_file_variables

  # Configuration settings for core resources
  deploy_core_landing_zones  = true
  custom_landing_zones       = module.settings.core.custom_landing_zones
  archetype_config_overrides = module.settings.core.archetype_config_overrides
  subscription_id_overrides  = module.settings.core.subscription_id_overrides

  # Configuration settings for identity resources
  deploy_identity_resources    = true
  configure_identity_resources = var.configure_identity_resources
  # subscription_id_identity     = var.subscription_id_identity

  # Configuration settings for connectivity resources
  deploy_connectivity_resources    = false
  # configure_connectivity_resources = module.settings.connectivity.configure_connectivity_resources
  # subscription_id_connectivity     = data.azurerm_client_config.connectivity.subscription_id

  # Configuration settings for management resources
  deploy_management_resources    = true
  #configure_management_resources = module.settings.management.configure_management_resources
  configure_management_resources = var.configure_management_resources
  #subscription_id_management     = data.azurerm_client_config.management.subscription_id
  subscription_id_management = var.subscription_id_management

}
