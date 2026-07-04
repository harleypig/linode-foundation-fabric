variable "linode_id" {
  description = "The ID of the Linode to share these IP addresses with."
  type        = number

  validation {
    condition     = var.linode_id > 0
    error_message = "Linode ID must be a positive integer."
  }
}

variable "addresses" {
  description = "A set of IP addresses to share to the Linode."
  type        = set(string)

  validation {
    condition     = length(var.addresses) > 0
    error_message = "At least one IP address must be provided to share."
  }

  validation {
    condition = alltrue([
      for address in var.addresses :
      can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", address)) || can(regex("^[0-9a-fA-F:]+$", address))
    ])
    error_message = "Each address must be a valid IPv4 (dotted-quad) or IPv6 address."
  }
}
