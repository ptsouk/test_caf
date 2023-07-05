# Configure the custom landing zones to deploy in
# addition the core resource hierarchy.
locals {
  custom_landing_zones = {
    # "${local.root_id}-Corp" = {
    #   display_name               = "Corp"
    #   parent_management_group_id = "${local.root_id}-landing-zones"
    #   subscription_ids           = values(local.subscription_ids_corp)
    #   archetype_config = {
    #     archetype_id = "customer_secure"
    #     parameters = {
    #       Deny-Resource-Locations = {
    #         listOfAllowedLocations = [
    #           local.primary_location,
    #           local.secondary_location
    #         ]
    #       }
    #       Deny-RSG-Locations = {
    #         listOfAllowedLocations = [
    #           local.primary_location,
    #           local.secondary_location
    #         ]
    #       }
    #     }
    #     access_control = {}
    #   }
    # },
    # "${local.root_id}-Online" = {
    #   display_name               = "Online"
    #   parent_management_group_id = "${local.root_id}-landing-zones"
    #   subscription_ids           = local.subscription_ids_online
    #   archetype_config = {
    #     archetype_id = "customer_secure"
    #     parameters = {
    #       Deny-Resource-Locations = {
    #         listOfAllowedLocations = [
    #           local.primary_location,
    #           local.secondary_location
    #         ]
    #       }
    #       Deny-RSG-Locations = {
    #         listOfAllowedLocations = [
    #           local.primary_location,
    #           local.secondary_location
    #         ]
    #       }
    #     }
    #     access_control = {}
    #   }
    # },
    # "${local.root_id}-connectivity" = {
    #   display_name               = "Connectivity"
    #   parent_management_group_id = "${local.root_id}-platform"
    #   subscription_ids           = [
    #     local.subscription_id_connectivity1,
    #     local.subscription_id_connectivity2
    #   ]
    #   archetype_config = {
    #     archetype_id = "es_connectivity"
    #     parameters = {
    #       Deny-Resource-Locations = {
    #         listOfAllowedLocations = [
    #           local.primary_location,
    #           local.secondary_location
    #         ]
    #       }
    #       Deny-RSG-Locations = {
    #         listOfAllowedLocations = [
    #           local.primary_location,
    #           local.secondary_location
    #         ]
    #       }
    #     }
    #     access_control = {}
    #   }
    # },
    # "${local.root_id}-identity" = {
    #   display_name               = "Identity"
    #   parent_management_group_id = "${local.root_id}-platform"
    #   subscription_ids           = [
    #     local.subscription_id_identity1,
    #     local.subscription_id_identity2
    #   ]
    #   archetype_config = {
    #     archetype_id = "es_identity"
    #     parameters = {
    #       Deny-Resource-Locations = {
    #         listOfAllowedLocations = [
    #           local.primary_location,
    #           local.secondary_location
    #         ]
    #       }
    #       Deny-RSG-Locations = {
    #         listOfAllowedLocations = [
    #           local.primary_location,
    #           local.secondary_location
    #         ]
    #       }
    #     }
    #     access_control = {}
    #   }
    # }
     "${local.root_id}-mycustommg" = {
      display_name               = "My Custom MG"
      parent_management_group_id = "${local.root_id}-management"
      subscription_ids           = [
        #local.subscription_id_identity1,
        local.subscription_id_identity2
      ]
      archetype_config = {
        archetype_id = "es_my_custom_mg"
        parameters = {}
        access_control = {}
      }
    }
  }
}

# Configure the archetype config overrides to customize
# the configuration.
locals {
  archetype_config_overrides = {
    identity = {
      archetype_id = "es_identity"
      parameters = {
        Deny-Subnet-Without-Nsg = {
          effect = "Audit"
        }
      }
      access_control = {}
    }
  }
}

# Configure the Subscription ID overrides to ensure
# Subscriptions are moved into the target management
# group.
locals {
  subscription_id_overrides = {
    root           = []
    decommissioned = []
    sandboxes      = []
    landing-zones  = [] # Not recommended, put Subscriptions in child management groups.
    platform       = [] # Not recommended, put Subscriptions in child management groups.
    connectivity   = [
      local.subscription_id_connectivity1,
      local.subscription_id_connectivity2
    ]
    management     = [
      local.subscription_id_management#,
      #local.subscription_id_security
    ]
    identity       = [
      local.subscription_id_identity1#,
      #local.subscription_id_identity2
    ]
    # corp           = values(local.subscription_ids_corp)
    corp           = local.subscription_ids_corp
    online         = local.subscription_ids_online
    sap            = []
    demo-corp      = []
    demo-online    = []
    demo-sap       = []
  }

}

# Configure custom input for testing the
# template_file_variables input.
locals {
  custom_template_file_variables = {
    # testStringKey = "testStringValue"
    # listOfAllowedLocations = [
    #   "eastus",
    #   "eastus2",
    #   "westus",
    #   "northcentralus",
    #   "southcentralus",
    # ]
  }
}
