variable "default_firewall_ids" {
  description = "The default firewall ID for a linode, nodebalancer, public_interface, or vpc_interface. Any field left unset is left to the account's computed default."
  type = object({
    linode           = optional(number)
    nodebalancer     = optional(number)
    public_interface = optional(number)
    vpc_interface    = optional(number)
  })
  default = null

  validation {
    condition = var.default_firewall_ids == null || alltrue([
      for id in values(var.default_firewall_ids) : id == null || id > 0
    ])
    error_message = "Each default firewall ID must be a positive integer when specified."
  }
}
