variable "label" {
  description = "The label of the VPC subnet."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9_-]*$", var.label))
    error_message = "Label must start with an alphanumeric character and can only contain alphanumeric characters, hyphens, and underscores."
  }

  validation {
    condition     = length(var.label) >= 1 && length(var.label) <= 64
    error_message = "Label must be between 1 and 64 characters long."
  }
}

variable "vpc_id" {
  description = "The id of the parent VPC for this VPC Subnet."
  type        = number

  validation {
    condition     = var.vpc_id > 0
    error_message = "VPC id must be a positive integer."
  }
}

variable "ipv4" {
  description = "The IPv4 range of this subnet in CIDR format."
  type        = string
  default     = null

  validation {
    condition     = var.ipv4 == null || can(cidrnetmask(var.ipv4))
    error_message = "ipv4 must be a valid IPv4 CIDR range (e.g. 10.0.1.0/24)."
  }
}

variable "ipv6" {
  description = "The IPv6 ranges of this subnet. Each range is an existing IPv6 prefix owned by the account, or a forward slash (/) followed by a valid prefix length; if unspecified, a range with the default prefix is allocated."
  type = list(object({
    range = optional(string)
  }))
  default = null

  validation {
    condition = var.ipv6 == null || alltrue([
      for entry in coalesce(var.ipv6, []) : entry.range == null || can(regex("^(/[0-9]{1,3}|[0-9a-fA-F:]+/[0-9]{1,3})$", entry.range))
    ])
    error_message = "Each ipv6 range must be an existing IPv6 prefix (e.g. 2600:3c00::/52) or a slash followed by a prefix length (e.g. /52)."
  }
}
