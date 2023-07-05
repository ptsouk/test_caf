locals {
    tenant_id                       = "f6279e07-c6ac-45ee-a551-12a2fdf33d14"
    primary_location                = "northeurope"
    root_id                         = "cnt-dev"
    root_name                       = "Contoso"
    secondary_location              = "brazilsouth"
    security_contact_email_address  = "panats@microsoft.com"
    subscription_id_connectivity1   = "29f2d419-72d6-4255-aa1c-bb787bdfcb12"
    subscription_id_connectivity2   = "e0255f0e-dd80-4f52-898c-61328e04c75f"
    subscription_id_identity1       = "d7467565-ae11-45ba-a20d-d59ce810e71d"
    subscription_id_identity2       = "c052627b-2e2b-49a6-ab01-2dd95c4d708f"
    subscription_id_management      = "8ec43e9c-d13a-4219-a0d5-43292d705a78"
    subscription_ids_corp           = ["795ed07b-f150-4728-b325-c7c82d6534aa"]
    subscription_ids_online         = []
    enable_ddos_protection_plan     = false
        
    # lz vending variables
    landing_zones = {
        landing_zone_1 = {
            subscription_id = local.subscription_id_identity1
            location = "northeurope"
            management_group_id = "${local.root_id}-identity"
            subscription_management_group_association_enabled = false
            virtual_networks = {
                vnet01 = {
                    name                    = "${local.root_id}-neu-identity-vnet-01"
                    address_space           = ["172.18.1.128/25"]
                    resource_group_name     = "${local.root_id}-neu-identity-network-rg"
                    hub_peering_enabled     = true
                    dns_servers             = ["172.20.30.11","172.20.30.12"]
                }
            }
        }
        landing_zone_2 = {
            subscription_id = local.subscription_id_identity2
            location = "brazilsouth"
            management_group_id = "${local.root_id}-identity"
            subscription_management_group_association_enabled = false
            virtual_networks = {
                vnet01 = {
                    name                    = "${local.root_id}-sbr-identity-vnet-01"
                    address_space           = ["172.18.3.128/25"]
                    resource_group_name     = "${local.root_id}-sbr-identity-network-rg"
                    hub_peering_enabled     = true
                    dns_servers             = ["172.20.30.11","172.20.30.12"]
                }
            }
        }
        landing_zone_3 = {
            subscription_id = local.subscription_ids_corp[0]
            location = "northeurope"
            management_group_id = "${local.root_id}-kaizenbet"
            subscription_management_group_association_enabled = false
            virtual_networks = {
                vnet01 = {
                    name                    = "${local.root_id}-neu-kaizenbet-vnet-01"
                    address_space           = ["172.18.8.0/21"]
                    resource_group_name     = "${local.root_id}-neu-kaizenbet-network-rg"
                    hub_peering_enabled     = true
                    dns_servers             = ["172.20.30.11","172.20.30.12"]
                }
            }
            #hub_network = "connectivity-1"
        }   
    }
}