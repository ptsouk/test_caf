output "default" {
  description = "Configuration settings for the deployment"
  value = {
    tenant_id = local.tenant_id
    primary_location= local.primary_location
    secondary_location = local.secondary_location
    root_id = local.root_id
    root_name = local.root_name
    security_contact_email_address = local.security_contact_email_address
    subscription_id_connectivity1 = local.subscription_id_connectivity1
    subscription_id_connectivity2 = local.subscription_id_connectivity2
    subscription_id_identity1 = local.subscription_id_identity1
    subscription_id_identity2 = local.subscription_id_identity2
    subscription_id_management = local.subscription_id_management
    subscription_ids_corp = local.subscription_ids_corp
    subscription_ids_online = local.subscription_ids_online
    enable_ddos_protection_plan = local.enable_ddos_protection_plan
    # vnet_resource_group_name_identity1 = local.vnet_resource_group_name_identity1
    # vnet_name_identity1 = local.vnet_name_identity1
    # vnet_address_space_identity1 = local.vnet_address_space_identity1
    # vnet_resource_group_name_identity2 = local.vnet_resource_group_name_identity2
    # vnet_name_identity2 = local.vnet_name_identity2
    # vnet_address_space_identity2 = local.vnet_address_space_identity2
  }
}

output "lzvending" {
  description = "Configuration settings for lz vending"
  value = {
    landing_zones = local.landing_zones
  }
  
}

output "connectivity" {
  description = "Configuration settings for the \"connectivity\" module instance."
  value = {
    configure_connectivity_resources1 = local.configure_connectivity_resources1
    configure_connectivity_resources2 = local.configure_connectivity_resources2
    configure_dns_resources           = local.configure_dns_resources
  }
}

output "core" {
  description = "Configuration settings for the \"core\" module instance."
  value = {
    custom_landing_zones           = local.custom_landing_zones
    archetype_config_overrides     = local.archetype_config_overrides
    subscription_id_overrides      = local.subscription_id_overrides
    custom_template_file_variables = local.custom_template_file_variables
    #configure_identity_resources   = local.configure_identity_resources
  }
}

output "identity" {
  description = "Configuration settings for the \"core\" module instance."
  value = {
    
    configure_identity_resources   = local.configure_identity_resources
  }
}

output "management" {
  description = "Configuration settings for the \"management\" module instance."
  value = {
    configure_management_resources = local.configure_management_resources
  }
}

output "shared" {
  description = "Configuration settings for the \"shared\" settings across module instances."
  value = {
    default_tags = local.default_tags
  }
}