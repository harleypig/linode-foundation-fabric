variable "linode_id" {
  description = "The ID of the Linode to allocate an IPv4 address for."
  type        = number
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
}

variable "apply_immediately" {
  description = "If true, the instance will be rebooted to update network interfaces."
  type        = bool
  default     = false
}
