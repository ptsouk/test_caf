variable "subscription_id_management" {
  type        = string
  description = "Sets the subscription ID to use for \"management\" resources."
}

variable configure_management_resources {
  description = "Sets the configure_management_resources MAP to use"
}
variable configure_identity_resources {
  description = "Sets the configure_identity_resources MAP to use"
}