provider "azurerm" {
  features {}
  alias           = "subscription_id_management"
  subscription_id = module.settings.default.subscription_id_management
}
provider "azurerm" {
  features {}
  alias           = "subscription_id_connectivity1"
  subscription_id = module.settings.default.subscription_id_connectivity1
}
provider "azurerm" {
  features {}
  alias           = "subscription_id_connectivity2"
  subscription_id = module.settings.default.subscription_id_connectivity2
}
provider "azurerm" {
  features {}
  alias           = "subscription_id_identity1"
  subscription_id = module.settings.default.subscription_id_identity1
}
provider "azurerm" {
  features {}
  alias           = "subscription_id_identity2"
  subscription_id = module.settings.default.subscription_id_identity2
}
# provider "azurerm" {
#   features {}
#   alias           = "subscription_ids_kaizenbet"
#   subscription_id = module.settings.default.subscription_ids_corp.kaizenbet
# }
# provider "azurerm" {
#   features {}
#   alias           = "subscription_ids_data"
#   subscription_id = module.settings.default.subscription_ids_corp.data
# }