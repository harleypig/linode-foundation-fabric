variable "username" {
  description = "The username to work with."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9_-]*$", var.username))
    error_message = "Username must start with an alphanumeric character and can only contain alphanumeric characters, hyphens, and underscores."
  }

  validation {
    condition     = length(var.username) >= 3 && length(var.username) <= 32
    error_message = "Username must be between 3 and 32 characters long."
  }
}

variable "account_access" {
  description = "The user account level access."
  type        = list(string)
  default     = null

  validation {
    condition     = var.account_access == null || alltrue([for a in coalesce(var.account_access, []) : length(a) > 0])
    error_message = "Each account_access entry must be a non-empty string."
  }
}

variable "entity_access" {
  description = "The user entity level access."
  type = list(object({
    id    = number
    roles = list(string)
    type  = string
  }))
  default = null

  validation {
    condition     = var.entity_access == null || alltrue([for e in coalesce(var.entity_access, []) : e.id > 0])
    error_message = "Each entity_access id must be a positive integer."
  }

  validation {
    condition     = var.entity_access == null || alltrue([for e in coalesce(var.entity_access, []) : length(e.roles) > 0])
    error_message = "Each entity_access entry must specify at least one role."
  }

  validation {
    condition     = var.entity_access == null || alltrue([for e in coalesce(var.entity_access, []) : length(e.type) > 0])
    error_message = "Each entity_access type must be a non-empty string."
  }
}
