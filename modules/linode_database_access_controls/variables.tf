variable "database_id" {
  description = "The ID of the database to manage the allow list for."
  type        = number

  validation {
    condition     = var.database_id > 0
    error_message = "Database ID must be a positive integer."
  }
}

variable "database_type" {
  description = "The type of the database to manage the allow list for."
  type        = string

  validation {
    condition     = contains(["mysql", "postgresql"], var.database_type)
    error_message = "Database type must be one of: mysql, postgresql."
  }
}

variable "allow_list" {
  description = "A list of IP addresses that can access the Managed Database. Each item can be a single IP address or a range in CIDR format."
  type        = set(string)

  validation {
    condition     = length(var.allow_list) > 0
    error_message = "At least one IP address or CIDR range must be provided in the allow list."
  }

  validation {
    condition = alltrue([
      for entry in var.allow_list :
      can(regex("^(([0-9]{1,3})\\.){3}([0-9]{1,3})(/([0-9]|[12][0-9]|3[0-2]))?$", entry)) ||
      can(regex("^([0-9a-fA-F:]+)(/[0-9]{1,3})?$", entry))
    ])
    error_message = "Each allow list entry must be a valid IPv4 or IPv6 address, optionally in CIDR notation."
  }
}
