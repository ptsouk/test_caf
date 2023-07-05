# import settings
module "settings" {
  source = "./settings"
}
# deploy core
module "core" {
  providers = {
    azurerm = azurerm.subscription_id_management
  }
  source                         = "./core"
  subscription_id_management     = module.settings.default.subscription_id_management
  configure_management_resources = module.settings.management.configure_management_resources
  configure_identity_resources   = module.settings.identity.configure_identity_resources
}
# deploy hub 1
module "connectivity-1" {
  providers = {
    azurerm = azurerm.subscription_id_connectivity1
  }
  source                           = "./connectivity"
  configure_connectivity_resources = module.settings.connectivity.configure_connectivity_resources1
  subscription_id_connectivity     = module.settings.default.subscription_id_connectivity1
}
# deploy hub 2
module "connectivity-2" {
  providers = {
    azurerm = azurerm.subscription_id_connectivity2
  }
  source                           = "./connectivity"
  configure_connectivity_resources = module.settings.connectivity.configure_connectivity_resources2
  subscription_id_connectivity     = module.settings.default.subscription_id_connectivity2
}
# deploy hub peerings

# deploy hub1 to hub2 peering
resource "azurerm_virtual_network_peering" "hub1TOhub2" {
  provider = azurerm.subscription_id_connectivity1
  depends_on = [
    module.connectivity-1,
    module.connectivity-2
  ]
  name                      = "hub1TOhub2"
  resource_group_name       = "${module.settings.default.root_id}-connectivity-${module.settings.default.primary_location}"
  virtual_network_name      = "${module.settings.default.root_id}-hub-${module.settings.default.primary_location}"
  remote_virtual_network_id = "/subscriptions/${module.settings.default.subscription_id_connectivity2}/resourceGroups/${module.settings.default.root_id}-connectivity-${module.settings.default.secondary_location}/providers/Microsoft.Network/virtualNetworks/${module.settings.default.root_id}-hub-${module.settings.default.secondary_location}"
  allow_gateway_transit     = true # set this one to true for allow connectivity with the other hub
}

# deploy hub2 to hub1 peering
resource "azurerm_virtual_network_peering" "hub2TOhub1" {
  provider = azurerm.subscription_id_connectivity2
  depends_on = [
    module.connectivity-1,
    module.connectivity-2,
    resource.azurerm_virtual_network_peering.hub1TOhub2
  ]
  name                      = "hub2TOhub1"
  resource_group_name       = "${module.settings.default.root_id}-connectivity-${module.settings.default.secondary_location}"
  virtual_network_name      = "${module.settings.default.root_id}-hub-${module.settings.default.secondary_location}"
  remote_virtual_network_id = "/subscriptions/${module.settings.default.subscription_id_connectivity1}/resourceGroups/${module.settings.default.root_id}-connectivity-${module.settings.default.primary_location}/providers/Microsoft.Network/virtualNetworks/${module.settings.default.root_id}-hub-${module.settings.default.primary_location}"
  use_remote_gateways       = true # set this one to true in order to allow connectivity to IE
}

# deploy identity 1 as spoke vnet
module "identity-1" {
  providers = {
    azurerm = azurerm.subscription_id_identity1
  }
  depends_on = [
    module.connectivity-1
  ]
  source                                            = "./lzvending"
  location                                          = module.settings.lzvending.landing_zones.landing_zone_1.location
  subscription_id                                   = module.settings.lzvending.landing_zones.landing_zone_1.subscription_id
  subscription_management_group_association_enabled = module.settings.lzvending.landing_zones.landing_zone_1.subscription_management_group_association_enabled
  management_group_id                               = module.settings.lzvending.landing_zones.landing_zone_1.management_group_id
  virtual_networks                                  = module.settings.lzvending.landing_zones.landing_zone_1.virtual_networks
  hub_network_resource_id                           = "/subscriptions/${module.settings.default.subscription_id_connectivity1}/resourceGroups/${module.settings.default.root_id}-connectivity-${module.settings.default.primary_location}/providers/Microsoft.Network/virtualNetworks/${module.settings.default.root_id}-hub-${module.settings.default.primary_location}"
}
# deploy identity 2 as spoke vnet
module "identity-2" {
  providers = {
    azurerm = azurerm.subscription_id_identity2
  }
  depends_on = [
    module.connectivity-1
  ]
  source                                            = "./lzvending"
  location                                          = module.settings.lzvending.landing_zones.landing_zone_2.location
  subscription_id                                   = module.settings.lzvending.landing_zones.landing_zone_2.subscription_id
  subscription_management_group_association_enabled = module.settings.lzvending.landing_zones.landing_zone_2.subscription_management_group_association_enabled
  management_group_id                               = module.settings.lzvending.landing_zones.landing_zone_2.management_group_id
  virtual_networks                                  = module.settings.lzvending.landing_zones.landing_zone_2.virtual_networks
  hub_network_resource_id                           = "/subscriptions/${module.settings.default.subscription_id_connectivity2}/resourceGroups/${module.settings.default.root_id}-connectivity-${module.settings.default.secondary_location}/providers/Microsoft.Network/virtualNetworks/${module.settings.default.root_id}-hub-${module.settings.default.secondary_location}"
}


module "dns_resources" {
  providers = {
    azurerm = azurerm.subscription_id_connectivity1
  }
  depends_on = [
    module.identity-1
  ]
  source                           = "./connectivity"
  configure_connectivity_resources = module.settings.connectivity.configure_dns_resources
  subscription_id_connectivity     = module.settings.default.subscription_id_connectivity1
}

# # deploy kaizenbet as spoke vnet
# module "kaizenbet" {
#   providers = {
#     azurerm = azurerm.subscription_ids_kaizenbet
#   }
#   depends_on = [
#     module.connectivity-1
#   ]
#   source                                            = "./lzvending"
#   location                                          = module.settings.lzvending.landing_zones.landing_zone_3.location
#   subscription_id                                   = module.settings.lzvending.landing_zones.landing_zone_3.subscription_id
#   subscription_management_group_association_enabled = module.settings.lzvending.landing_zones.landing_zone_3.subscription_management_group_association_enabled
#   management_group_id                               = module.settings.lzvending.landing_zones.landing_zone_3.management_group_id
#   virtual_networks                                  = module.settings.lzvending.landing_zones.landing_zone_3.virtual_networks
#   hub_network_resource_id                           = "/subscriptions/${module.settings.default.subscription_id_connectivity1}/resourceGroups/${module.settings.default.root_id}-connectivity-${module.settings.default.primary_location}/providers/Microsoft.Network/virtualNetworks/${module.settings.default.root_id}-hub-${module.settings.default.primary_location}"
# }

# # deploy databrick data landing zone as spoke vnet
# module "data" {
#   providers = {
#     azurerm = azurerm.subscription_ids_data
#   }
#   depends_on = [
#     module.connectivity-1
#   ]
#   source                                            = "./lzvending"
#   location                                          = module.settings.lzvending.landing_zones.landing_zone_4.location
#   subscription_id                                   = module.settings.lzvending.landing_zones.landing_zone_4.subscription_id
#   subscription_management_group_association_enabled = module.settings.lzvending.landing_zones.landing_zone_4.subscription_management_group_association_enabled
#   management_group_id                               = module.settings.lzvending.landing_zones.landing_zone_4.management_group_id
#   virtual_networks                                  = module.settings.lzvending.landing_zones.landing_zone_4.virtual_networks
#   hub_network_resource_id                           = "/subscriptions/${module.settings.default.subscription_id_connectivity1}/resourceGroups/${module.settings.default.root_id}-connectivity-${module.settings.default.primary_location}/providers/Microsoft.Network/virtualNetworks/${module.settings.default.root_id}-hub-${module.settings.default.primary_location}"
# }