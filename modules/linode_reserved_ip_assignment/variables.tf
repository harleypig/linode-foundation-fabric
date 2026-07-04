variable "address" {
  description = "The resulting IPv4 address. This must be an already-reserved IPv4 address on the account."
  type        = string

  validation {
    condition     = can(regex("^([0-9]{1,3}[.]){3}[0-9]{1,3}$", var.address))
    error_message = "Address must be a valid dotted-quad IPv4 address (e.g. 192.0.2.10)."
  }
}

variable "linode_id" {
  description = "The ID of the Linode to allocate an IPv4 address for."
  type        = number

  validation {
    condition     = var.linode_id > 0
    error_message = "Linode ID must be a positive integer."
  }
}

variable "apply_immediately" {
  description = "If true, the instance will be rebooted to update network interfaces. This functionality is not affected by the `skip_implicit_reboots` provider argument."
  type        = bool
  default     = null
}

variable "public" {
  description = "Whether the IPv4 address is public or private."
  type        = bool
  default     = null
}

variable "rdns" {
  description = "The reverse DNS assigned to this address."
  type        = string
  default     = null

  validation {
    condition     = var.rdns == null || can(regex("^[a-zA-Z0-9]([a-zA-Z0-9.-]*[a-zA-Z0-9])?$", var.rdns))
    error_message = "rDNS must be a valid hostname (alphanumeric characters, hyphens, and dots)."
  }
}
