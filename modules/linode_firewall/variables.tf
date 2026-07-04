variable "label" {
  description = "This Firewall's unique label."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9_-]*$", var.label))
    error_message = "Label must start with an alphanumeric character and can only contain alphanumeric characters, hyphens, and underscores."
  }

  validation {
    condition     = length(var.label) >= 3 && length(var.label) <= 32
    error_message = "Label must be between 3 and 32 characters long."
  }
}

variable "disabled" {
  description = "If true, the Firewall's rules are not enforced."
  type        = bool
  default     = false
}

variable "inbound_policy" {
  description = "Default behavior for inbound traffic not matched by a rule. Defaults to DROP for a least-privilege posture."
  type        = string
  default     = "DROP"

  validation {
    condition     = contains(["ACCEPT", "DROP"], var.inbound_policy)
    error_message = "inbound_policy must be either ACCEPT or DROP."
  }
}

variable "outbound_policy" {
  description = "Default behavior for outbound traffic not matched by a rule."
  type        = string
  default     = "ACCEPT"

  validation {
    condition     = contains(["ACCEPT", "DROP"], var.outbound_policy)
    error_message = "outbound_policy must be either ACCEPT or DROP."
  }
}

variable "inbound" {
  description = "Inbound firewall rules. With the default inbound_policy of DROP, an empty list blocks all inbound traffic; add one rule per class of traffic to allow."
  type = list(object({
    label    = string
    action   = string
    protocol = string
    ports    = optional(string)
    ipv4     = optional(list(string))
    ipv6     = optional(list(string))
  }))
  default = []

  validation {
    condition     = alltrue([for r in var.inbound : contains(["ACCEPT", "DROP"], r.action)])
    error_message = "Each inbound rule action must be either ACCEPT or DROP."
  }

  validation {
    condition     = alltrue([for r in var.inbound : contains(["TCP", "UDP", "ICMP"], r.protocol)])
    error_message = "Each inbound rule protocol must be one of TCP, UDP, or ICMP."
  }

  validation {
    condition     = alltrue([for r in var.inbound : r.protocol != "ICMP" || r.ports == null])
    error_message = "ICMP rules must not specify ports (the Linode API rejects them)."
  }
}

variable "outbound" {
  description = "Outbound firewall rules. With the default outbound_policy of ACCEPT, an empty list permits all outbound traffic; add rules only to constrain it."
  type = list(object({
    label    = string
    action   = string
    protocol = string
    ports    = optional(string)
    ipv4     = optional(list(string))
    ipv6     = optional(list(string))
  }))
  default = []

  validation {
    condition     = alltrue([for r in var.outbound : contains(["ACCEPT", "DROP"], r.action)])
    error_message = "Each outbound rule action must be either ACCEPT or DROP."
  }

  validation {
    condition     = alltrue([for r in var.outbound : contains(["TCP", "UDP", "ICMP"], r.protocol)])
    error_message = "Each outbound rule protocol must be one of TCP, UDP, or ICMP."
  }

  validation {
    condition     = alltrue([for r in var.outbound : r.protocol != "ICMP" || r.ports == null])
    error_message = "ICMP rules must not specify ports (the Linode API rejects them)."
  }
}

variable "linodes" {
  description = "IDs of Linodes this Firewall governs network traffic for."
  type        = list(number)
  default     = []

  validation {
    condition     = alltrue([for id in var.linodes : id > 0])
    error_message = "Each Linode ID must be a positive integer."
  }
}

variable "nodebalancers" {
  description = "IDs of NodeBalancers this Firewall governs network traffic for."
  type        = list(number)
  default     = []

  validation {
    condition     = alltrue([for id in var.nodebalancers : id > 0])
    error_message = "Each NodeBalancer ID must be a positive integer."
  }
}

variable "tags" {
  description = "An array of tags applied to this object."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.tags) <= 64
    error_message = "A maximum of 64 tags can be applied to a firewall."
  }

  validation {
    condition = alltrue([
      for tag in var.tags : can(regex("^[a-zA-Z0-9:_-]+$", tag)) && length(tag) >= 3 && length(tag) <= 50
    ])
    error_message = "Each tag must be 3-50 characters long and contain only alphanumeric characters, colons, hyphens, and underscores."
  }
}
