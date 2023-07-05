# Configure the connectivity resources settings.

locals {
  configure_connectivity_resources1 = {
    settings = {
      hub_networks = flatten([
        [{
          enabled = true
          config = {
            address_space                = ["172.18.1.0/25"]
            location                     = local.primary_location
            link_to_ddos_protection_plan = local.enable_ddos_protection_plan
            dns_servers                  = ["172.20.30.11", "172.20.30.12"]
            bgp_community                = ""
            subnets = [
              {
                name = "Inside_Subnet"
                address_prefixes = [
                  "172.18.1.0/28"
                ]
              },
              {
                name = "Outside_Subnet"
                address_prefixes = [
                  "172.18.1.16/28"
                ]
              },
              {
                name = "Management_Subnet"
                address_prefixes = [
                  "172.18.1.32/28"
                ]
              },
              {
                name = "Diagnostics_Subnet"
                address_prefixes = [
                  "172.18.1.48/28"
                ]
              }
            ]
            virtual_network_gateway = {
              enabled = true
              config = {
                address_prefix           = "172.18.1.64/27"
                gateway_sku_expressroute = "ErGw1AZ"
                gateway_sku_vpn          = ""
                advanced_vpn_settings = {
                  enable_bgp                       = null
                  active_active                    = null
                  private_ip_address_allocation    = ""
                  default_local_network_gateway_id = ""
                  vpn_client_configuration         = []
                  bgp_settings                     = []
                  custom_route                     = []
                }
              }
            }
            azure_firewall = {
              enabled = false
              config = {
                address_prefix                = ""
                enable_dns_proxy              = true
                dns_servers                   = []
                sku_tier                      = ""
                base_policy_id                = ""
                private_ip_ranges             = []
                threat_intelligence_mode      = ""
                threat_intelligence_allowlist = []
                availability_zones = {
                  zone_1 = true
                  zone_2 = true
                  zone_3 = true
                }
              }
            }
            spoke_virtual_network_resource_ids      = []
            enable_outbound_virtual_network_peering = false
            enable_hub_network_mesh_peering         = false
          }
        }]
      ])
      vwan_hub_networks = []
      ddos_protection_plan = {
        enabled = local.enable_ddos_protection_plan
        config = {
          location = ""
        }
      }
      dns = {
        enabled = false
        config = {
          location                                               = null
          enable_private_link_by_service                         = {}
          private_link_locations                                 = []
          public_dns_zones                                       = []
          private_dns_zones                                      = []
          enable_private_dns_zone_virtual_network_link_on_hubs   = false
          enable_private_dns_zone_virtual_network_link_on_spokes = false
          virtual_network_resource_ids_to_link                   = []
        }
      }
    }
    location = ""
    tags     = {}
    advanced = {}
  }
  configure_connectivity_resources2 = {
    settings = {
      hub_networks = flatten([
        [{
          enabled = true
          config = {
            address_space                = ["172.18.3.0/25"]
            location                     = local.secondary_location
            link_to_ddos_protection_plan = local.enable_ddos_protection_plan
            dns_servers                  = ["172.20.30.11", "172.20.30.12"]
            bgp_community                = ""
            subnets = [
              {
                name = "Inside_Subnet"
                address_prefixes = [
                  "172.18.3.0/28"
                ]
              },
              {
                name = "Outside_Subnet"
                address_prefixes = [
                  "172.18.3.16/28"
                ]
              },
              {
                name = "Management_Subnet"
                address_prefixes = [
                  "172.18.3.32/28"
                ]
              },
              {
                name = "Diagnostics_Subnet"
                address_prefixes = [
                  "172.18.3.48/28"
                ]
              }
            ]
            virtual_network_gateway = {
              enabled = false
              config = {
                address_prefix           = ""
                gateway_sku_expressroute = ""
                gateway_sku_vpn          = ""
                advanced_vpn_settings = {
                  enable_bgp                       = null
                  active_active                    = null
                  private_ip_address_allocation    = ""
                  default_local_network_gateway_id = ""
                  vpn_client_configuration         = []
                  bgp_settings                     = []
                  custom_route                     = []
                }
              }
            }
            azure_firewall = {
              enabled = false
              config = {
                address_prefix                = ""
                enable_dns_proxy              = true
                dns_servers                   = []
                sku_tier                      = ""
                base_policy_id                = ""
                private_ip_ranges             = []
                threat_intelligence_mode      = ""
                threat_intelligence_allowlist = []
                availability_zones = {
                  zone_1 = true
                  zone_2 = true
                  zone_3 = true
                }
              }
            }
            spoke_virtual_network_resource_ids      = []
            enable_outbound_virtual_network_peering = false
            enable_hub_network_mesh_peering         = false
          }
        }]
      ])
      vwan_hub_networks = []
      ddos_protection_plan = {
        enabled = local.enable_ddos_protection_plan
        config = {
          location = ""
        }
      }
      dns = {
        enabled = false
        config = {
          location                                               = null
          enable_private_link_by_service                         = {}
          private_link_locations                                 = []
          public_dns_zones                                       = []
          private_dns_zones                                      = []
          enable_private_dns_zone_virtual_network_link_on_hubs   = false
          enable_private_dns_zone_virtual_network_link_on_spokes = false
          virtual_network_resource_ids_to_link                   = []
        }
      }
    }
    location = ""
    tags     = {}
    advanced = {}
  }
  configure_dns_resources = {
    settings = {
      hub_networks = flatten([
        [{
          enabled = false
          config = {
            address_space                = []
            location                     = ""
            link_to_ddos_protection_plan = local.enable_ddos_protection_plan
            dns_servers                  = []
            bgp_community                = ""
            subnets = []
            virtual_network_gateway = {
              enabled = false
              config = {
                address_prefix           = ""
                gateway_sku_expressroute = ""
                gateway_sku_vpn          = ""
                advanced_vpn_settings = {
                  enable_bgp                       = null
                  active_active                    = null
                  private_ip_address_allocation    = ""
                  default_local_network_gateway_id = ""
                  vpn_client_configuration         = []
                  bgp_settings                     = []
                  custom_route                     = []
                }
              }
            }
            azure_firewall = {
              enabled = false
              config = {
                address_prefix                = ""
                enable_dns_proxy              = true
                dns_servers                   = []
                sku_tier                      = ""
                base_policy_id                = ""
                private_ip_ranges             = []
                threat_intelligence_mode      = ""
                threat_intelligence_allowlist = []
                availability_zones = {
                  zone_1 = true
                  zone_2 = true
                  zone_3 = true
                }
              }
            }
            spoke_virtual_network_resource_ids      = []
            enable_outbound_virtual_network_peering = false
            enable_hub_network_mesh_peering         = false
          }
        }]
      ])
      vwan_hub_networks = []
      ddos_protection_plan = {
        enabled = local.enable_ddos_protection_plan
        config = {
          location = ""
        }
      }
      dns = {
        enabled = true
        config = {
          location = null
          enable_private_link_by_service = {
            azure_api_management                 = false
            azure_app_configuration_stores       = false
            azure_arc                            = false
            azure_automation_dscandhybridworker  = false
            azure_automation_webhook             = false
            azure_backup                         = false
            azure_batch_account                  = false
            azure_bot_service_bot                = false
            azure_bot_service_token              = false
            azure_cache_for_redis                = false
            azure_cache_for_redis_enterprise     = false
            azure_container_registry             = false
            azure_cosmos_db_cassandra            = false
            azure_cosmos_db_gremlin              = false
            azure_cosmos_db_mongodb              = false
            azure_cosmos_db_sql                  = false
            azure_cosmos_db_table                = false
            azure_data_explorer                  = false
            azure_data_factory                   = false
            azure_data_factory_portal            = false
            azure_data_health_data_services      = false
            azure_data_lake_file_system_gen2     = false
            azure_database_for_mariadb_server    = false
            azure_database_for_mysql_server      = false
            azure_database_for_postgresql_server = false
            azure_digital_twins                  = false
            azure_event_grid_domain              = false
            azure_event_grid_topic               = false
            azure_event_hubs_namespace           = false
            azure_file_sync                      = false
            azure_hdinsights                     = false
            azure_iot_dps                        = false
            azure_iot_hub                        = false
            azure_key_vault                      = false
            azure_key_vault_managed_hsm          = false
            azure_kubernetes_service_management  = false
            azure_machine_learning_workspace     = false
            azure_managed_disks                  = false
            azure_media_services                 = false
            azure_migrate                        = false
            azure_monitor                        = false
            azure_purview_account                = false
            azure_purview_studio                 = false
            azure_relay_namespace                = false
            azure_search_service                 = false
            azure_service_bus_namespace          = false
            azure_site_recovery                  = false
            azure_sql_database_sqlserver         = false
            azure_synapse_analytics_dev          = false
            azure_synapse_analytics_sql          = false
            azure_synapse_studio                 = false
            azure_web_apps_sites                 = false
            azure_web_apps_static_sites          = false
            cognitive_services_account           = false
            microsoft_power_bi                   = false
            signalr                              = false
            signalr_webpubsub                    = false
            storage_account_blob                 = true
            storage_account_file                 = false
            storage_account_queue                = false
            storage_account_table                = false
            storage_account_web                  = false
          }
          private_link_locations                                 = []
          public_dns_zones                                       = []
          private_dns_zones                                      = []
          enable_private_dns_zone_virtual_network_link_on_hubs   = false
          enable_private_dns_zone_virtual_network_link_on_spokes = false
          virtual_network_resource_ids_to_link = [
            "/subscriptions/${local.subscription_id_identity1}/resourceGroups/${local.landing_zones.landing_zone_1.virtual_networks.vnet01.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${local.landing_zones.landing_zone_1.virtual_networks.vnet01.name}"
          ]
        }
      }
    }
    location = ""
    tags     = {}
    advanced = {}
  }
}
