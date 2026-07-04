variable "linode_id" {
  description = "The ID of the Linode to assign this interface to."
  type        = number

  validation {
    condition     = var.linode_id > 0
    error_message = "linode_id must be a positive integer."
  }
}

variable "firewall_id" {
  description = "ID of an enabled firewall to secure a VPC or public interface. Not allowed for VLAN interfaces."
  type        = number
  default     = null

  validation {
    condition     = var.firewall_id == null || var.firewall_id > 0
    error_message = "firewall_id must be a positive integer when specified."
  }
}

variable "default_route" {
  description = "Indicates if the interface serves as the default route when multiple interfaces are eligible for this role."
  type = object({
    ipv4 = optional(bool)
    ipv6 = optional(bool)
  })
  default = null
}

variable "public" {
  description = "Linode public interface. Mutually exclusive with vlan and vpc. Pass an empty object ({}) for a public interface with auto-assigned addresses."
  type = object({
    ipv4 = optional(object({
      addresses = optional(list(object({
        address = optional(string)
        primary = optional(bool)
      })))
    }))
    ipv6 = optional(object({
      ranges = optional(list(object({
        range = string
      })))
    }))
  })
  default = null
}

variable "vlan" {
  description = "Linode VLAN interface. Mutually exclusive with public and vpc."
  type = object({
    vlan_label   = string
    ipam_address = optional(string)
  })
  default = null

  validation {
    condition     = var.vlan == null || can(regex("^[a-zA-Z0-9][a-zA-Z0-9_-]*$", var.vlan.vlan_label))
    error_message = "vlan.vlan_label must start with an alphanumeric character and contain only alphanumerics, hyphens, and underscores."
  }

  validation {
    condition     = var.vlan == null || (length(var.vlan.vlan_label) >= 1 && length(var.vlan.vlan_label) <= 64)
    error_message = "vlan.vlan_label must be between 1 and 64 characters long."
  }
}

variable "vpc" {
  description = "Linode VPC interface. Mutually exclusive with public and vlan."
  type = object({
    subnet_id = number
    ipv4 = optional(object({
      addresses = optional(list(object({
        address         = optional(string)
        nat_1_1_address = optional(string)
        primary         = optional(bool)
      })))
      ranges = optional(list(object({
        range = string
      })))
    }))
    ipv6 = optional(object({
      is_public = optional(bool)
      ranges = optional(list(object({
        range = optional(string)
      })))
      slaac = optional(list(object({
        range = optional(string)
      })))
    }))
  })
  default = null

  validation {
    condition     = var.vpc == null || var.vpc.subnet_id > 0
    error_message = "vpc.subnet_id must be a positive integer."
  }
}
