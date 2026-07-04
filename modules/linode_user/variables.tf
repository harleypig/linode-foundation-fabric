variable "username" {
  description = "The username of the user."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,31}$", var.username))
    error_message = "Username must start with an alphanumeric character, be 3-32 characters long, and contain only alphanumeric characters, hyphens, and underscores."
  }
}

variable "email" {
  description = "The email of the user."
  type        = string

  validation {
    condition     = can(regex("^[^@[:space:]]+@[^@[:space:]]+\\.[^@[:space:]]+$", var.email))
    error_message = "Email must be a valid email address."
  }
}

variable "restricted" {
  description = "If true, the user must be explicitly granted access to platform actions and entities."
  type        = bool
  default     = false
}

variable "global_grants" {
  description = "A structure containing the Account-level grants a User has."
  type = object({
    account_access        = optional(string)
    add_databases         = optional(bool)
    add_domains           = optional(bool)
    add_firewalls         = optional(bool)
    add_images            = optional(bool)
    add_linodes           = optional(bool)
    add_longview          = optional(bool)
    add_nodebalancers     = optional(bool)
    add_stackscripts      = optional(bool)
    add_volumes           = optional(bool)
    add_vpcs              = optional(bool)
    cancel_account        = optional(bool)
    longview_subscription = optional(bool)
  })
  default = null

  validation {
    condition = var.global_grants == null || var.global_grants.account_access == null || contains(
      ["read_only", "read_write"], var.global_grants.account_access
    )
    error_message = "global_grants.account_access must be either read_only or read_write when set."
  }
}

variable "domain_grant" {
  description = "A set of the user's grants to specific Domains."
  type = list(object({
    id          = number
    permissions = string
  }))
  default = []

  validation {
    condition = alltrue([
      for g in var.domain_grant : contains(["read_only", "read_write"], g.permissions) && g.id > 0
    ])
    error_message = "Each domain_grant must have permissions of read_only or read_write and a positive entity id."
  }
}

variable "firewall_grant" {
  description = "A set of the user's grants to specific Firewalls."
  type = list(object({
    id          = number
    permissions = string
  }))
  default = []

  validation {
    condition = alltrue([
      for g in var.firewall_grant : contains(["read_only", "read_write"], g.permissions) && g.id > 0
    ])
    error_message = "Each firewall_grant must have permissions of read_only or read_write and a positive entity id."
  }
}

variable "image_grant" {
  description = "A set of the user's grants to specific Images."
  type = list(object({
    id          = number
    permissions = string
  }))
  default = []

  validation {
    condition = alltrue([
      for g in var.image_grant : contains(["read_only", "read_write"], g.permissions) && g.id > 0
    ])
    error_message = "Each image_grant must have permissions of read_only or read_write and a positive entity id."
  }
}

variable "linode_grant" {
  description = "A set of the user's grants to specific Linodes."
  type = list(object({
    id          = number
    permissions = string
  }))
  default = []

  validation {
    condition = alltrue([
      for g in var.linode_grant : contains(["read_only", "read_write"], g.permissions) && g.id > 0
    ])
    error_message = "Each linode_grant must have permissions of read_only or read_write and a positive entity id."
  }
}

variable "longview_grant" {
  description = "A set of the user's grants to specific Longview clients."
  type = list(object({
    id          = number
    permissions = string
  }))
  default = []

  validation {
    condition = alltrue([
      for g in var.longview_grant : contains(["read_only", "read_write"], g.permissions) && g.id > 0
    ])
    error_message = "Each longview_grant must have permissions of read_only or read_write and a positive entity id."
  }
}

variable "nodebalancer_grant" {
  description = "A set of the user's grants to specific NodeBalancers."
  type = list(object({
    id          = number
    permissions = string
  }))
  default = []

  validation {
    condition = alltrue([
      for g in var.nodebalancer_grant : contains(["read_only", "read_write"], g.permissions) && g.id > 0
    ])
    error_message = "Each nodebalancer_grant must have permissions of read_only or read_write and a positive entity id."
  }
}

variable "stackscript_grant" {
  description = "A set of the user's grants to specific StackScripts."
  type = list(object({
    id          = number
    permissions = string
  }))
  default = []

  validation {
    condition = alltrue([
      for g in var.stackscript_grant : contains(["read_only", "read_write"], g.permissions) && g.id > 0
    ])
    error_message = "Each stackscript_grant must have permissions of read_only or read_write and a positive entity id."
  }
}

variable "volume_grant" {
  description = "A set of the user's grants to specific Volumes."
  type = list(object({
    id          = number
    permissions = string
  }))
  default = []

  validation {
    condition = alltrue([
      for g in var.volume_grant : contains(["read_only", "read_write"], g.permissions) && g.id > 0
    ])
    error_message = "Each volume_grant must have permissions of read_only or read_write and a positive entity id."
  }
}

variable "vpc_grant" {
  description = "A set of the user's grants to specific Virtual Private Clouds (VPCs)."
  type = list(object({
    id          = number
    permissions = string
  }))
  default = []

  validation {
    condition = alltrue([
      for g in var.vpc_grant : contains(["read_only", "read_write"], g.permissions) && g.id > 0
    ])
    error_message = "Each vpc_grant must have permissions of read_only or read_write and a positive entity id."
  }
}
