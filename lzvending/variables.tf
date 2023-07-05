variable "location" {
  type        = string
  description = "Sets the resources location"
}
# variable "subscription_display_name" {
#   type        = string
#   description = "Sets the subscription display name"
# }
# variable "subscription_alias_name" {
#   type        = string
#   description = "Sets the subscription alias name"
# }
# variable "subscription_workload" {
#   type        = string
#   description = "Sets the type of workload"
# }
 
variable "subscription_id" {
  type        = string
  description = "Sets the existing subscription."
} 
variable "management_group_id" {
  type        = string
  description = "Sets the parent MG."
} 
variable "subscription_management_group_association_enabled" {
  type        = bool
  description = "controls the placement to a MG."
}
variable "virtual_networks" {
  description = "Sets the vnets to deploy"
}

variable "hub_network_resource_id" {
    type        = string
  description = "Sets the hub vnet peering target"
}
