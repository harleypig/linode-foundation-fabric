variable "region" {
  description = "The location where the Linode is deployed."
  type        = string

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+$", var.region))
    error_message = "region must be a valid Linode region id (e.g. us-central, us-mia, eu-west)."
  }
}

variable "type" {
  description = "The Linode type defines the pricing, CPU, disk, and RAM specs of the instance."
  type        = string

  validation {
    condition     = can(regex("^g[0-9]+-", var.type))
    error_message = "type must be a valid Linode type id (e.g. g6-standard-1)."
  }
}

variable "label" {
  description = "The Linode's label for display purposes."
  type        = string
  default     = null

  validation {
    condition     = var.label == null || (length(var.label) >= 3 && length(var.label) <= 64 && can(regex("^[a-zA-Z0-9][a-zA-Z0-9._-]*$", var.label)))
    error_message = "Label, when set, must be 3-64 chars, start alphanumeric, and contain only letters, digits, dots, hyphens, underscores."
  }
}

variable "tags" {
  description = "A list of tags applied to this object."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.tags) <= 64
    error_message = "A maximum of 64 tags can be applied."
  }

  validation {
    condition     = alltrue([for tag in var.tags : can(regex("^[a-zA-Z0-9:_-]+$", tag)) && length(tag) >= 3 && length(tag) <= 50])
    error_message = "Each tag must be 3-50 characters and contain only alphanumeric characters, colons, hyphens, and underscores."
  }
}

variable "private_ip" {
  description = "If true, the created Linode will have private networking enabled."
  type        = bool
  default     = false
}

variable "shared_ipv4" {
  description = "A set of IPv4 addresses to be shared with the Instance."
  type        = list(string)
  default     = []
}

variable "placement_group_externally_managed" {
  description = "If true, changes to the Linode's assigned Placement Group will be ignored."
  type        = bool
  default     = false
}

variable "resize_disk" {
  description = "If true, changes in Linode type will attempt to upsize or downsize implicitly created disks."
  type        = bool
  default     = false
}

variable "backups_enabled" {
  description = "If true, the created Linode will automatically be enrolled in the Linode Backup service."
  type        = bool
  default     = false
}

variable "watchdog_enabled" {
  description = "The watchdog, named Lassie, is a Shutdown Watchdog that monitors your Linode."
  type        = bool
  default     = false
}

variable "booted" {
  description = "If true, then the instance is kept or converted into a running state."
  type        = bool
  default     = true
}

variable "migration_type" {
  description = "The type of migration to use when updating the type or region of a Linode."
  type        = string
  default     = "cold"

  validation {
    condition     = contains(["warm", "cold"], var.migration_type)
    error_message = "migration_type must be warm or cold."
  }
}

variable "firewall_id" {
  description = "The ID of the Firewall to attach to the instance upon creation."
  type        = string
  default     = null

  validation {
    condition     = var.firewall_id == null || can(regex("^[0-9]+$", var.firewall_id))
    error_message = "firewall_id must be a numeric ID string when set."
  }
}

variable "disk_encryption" {
  description = "The disk encryption policy for this instance."
  type        = string
  default     = "enabled"

  validation {
    condition     = contains(["enabled", "disabled"], var.disk_encryption)
    error_message = "disk_encryption must be enabled or disabled."
  }
}

variable "backup_id" {
  description = "A Backup ID from another Linode's available backups."
  type        = string
  default     = null

  validation {
    condition     = var.backup_id == null || can(regex("^[0-9]+$", var.backup_id))
    error_message = "backup_id must be a numeric ID string when set."
  }
}

variable "image" {
  description = "An Image ID to deploy the Disk from."
  type        = string
  default     = null
}

variable "root_pass" {
  description = "The initial password for the root user account."
  type        = string
  default     = null
}

variable "authorized_keys" {
  description = "A list of SSH public keys to deploy for the root user."
  type        = list(string)
  default     = []
}

variable "authorized_users" {
  description = "A list of Linode usernames. If the usernames have associated SSH keys, the keys will be appended to the root user's ~/.ssh/authorized_keys file automatically."
  type        = list(string)
  default     = []
}

variable "stackscript_id" {
  description = "The StackScript to deploy to the newly created Linode."
  type        = string
  default     = null

  validation {
    condition     = var.stackscript_id == null || can(regex("^[0-9]+$", var.stackscript_id))
    error_message = "stackscript_id must be a numeric ID string when set."
  }
}

variable "stackscript_data" {
  description = "An object containing responses to any User Defined Fields present in the StackScript being deployed to this Linode."
  type        = map(any)
  default     = {}
}

variable "swap_size" {
  description = "The swap disk size for the newly-created Linode."
  type        = number
  default     = 512

  validation {
    condition     = var.swap_size >= 0
    error_message = "swap_size must be >= 0."
  }
}

variable "metadata" {
  description = "The metadata configuration for the Linode instance."
  type = object({
    user_data = string
  })
  default = null
}

variable "placement_group_id" {
  description = "The ID of the Placement Group to assign this Linode to."
  type        = string
  default     = null

  validation {
    condition     = var.placement_group_id == null || can(regex("^[0-9]+$", var.placement_group_id))
    error_message = "placement_group_id must be a numeric ID string when set."
  }
}

variable "alerts" {
  description = "The alerts configuration for the Linode instance."
  type = object({
    cpu            = optional(number)
    network_in     = optional(number)
    network_out    = optional(number)
    transfer_quota = optional(number)
    io             = optional(number)
  })
  default = null

  validation {
    condition     = var.alerts == null || alltrue([for v in values(var.alerts) : v == null || v >= 0])
    error_message = "alert thresholds must be >= 0."
  }
}

variable "timeouts" {
  description = "The timeouts configuration for the Linode instance."
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null

  validation {
    condition     = var.timeouts == null || alltrue([for t in values(var.timeouts) : t == null || can(regex("^[0-9]+[smh]$", t))])
    error_message = "Timeout values must be a number followed by s, m, or h."
  }
}
