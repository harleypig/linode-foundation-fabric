variable "prefix_length" {
  description = "The prefix length of the IPv6 range."
  type        = number

  validation {
    condition     = contains([56, 64], var.prefix_length)
    error_message = "Prefix length must be either 56 or 64."
  }
}

variable "linode_id" {
  description = "The ID of the Linode to assign this range to."
  type        = number
  default     = null

  validation {
    condition     = var.linode_id == null || var.linode_id > 0
    error_message = "Linode ID must be a positive integer when specified."
  }
}

variable "route_target" {
  description = "The IPv6 SLAAC address to assign this range to."
  type        = string
  default     = null

  validation {
    condition     = var.route_target == null || can(regex("^([0-9a-fA-F]{0,4}:){2,7}[0-9a-fA-F]{0,4}$", var.route_target))
    error_message = "Route target must be a valid IPv6 address."
  }
}
