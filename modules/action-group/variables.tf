variable "action_groups" {
  description = "Azure Monitor Action Group configurations"

  type = map(object({
    name                = string
    resource_group_name = string
    short_name          = string
    email_name          = string
    email_address       = string
  }))
}