variable "linode_id" {
  description = "The ID of the Linode to allocate an IPv4 address for."
  type        = number

  validation {
    condition     = var.linode_id > 0
    error_message = "Linode ID must be a positive integer."
  }
}

variable "public" {
  description = "Whether the IPv4 address is public or private. Defaults to true."
  type        = bool
  default     = true
}

variable "rdns" {
  description = "The reverse DNS assigned to this address."
  type        = string
  default     = null

  validation {
    condition     = var.rdns == null || can(regex("^[A-Za-z0-9.-]+$", var.rdns))
    error_message = "rdns must be a valid hostname (letters, digits, dots, hyphens)."
  }
}

variable "apply_immediately" {
  description = "If true, the instance will be rebooted to update network interfaces."
  type        = bool
  default     = false
}
