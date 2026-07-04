variable "linode_id" {
  description = "The ID of the Linode to create this Disk under."
  type        = number

  validation {
    condition     = var.linode_id > 0
    error_message = "Linode ID must be a positive integer."
  }
}

variable "label" {
  description = "The Disk's label for display purposes only."
  type        = string

  validation {
    condition     = length(var.label) >= 1 && length(var.label) <= 48 && can(regex("^[a-zA-Z0-9][a-zA-Z0-9._-]*$", var.label))
    error_message = "Label must be 1-48 chars, start alphanumeric, and contain only letters, digits, dots, hyphens, underscores."
  }
}

variable "size" {
  description = "The size of the Disk in MB."
  type        = number

  validation {
    condition     = var.size > 0
    error_message = "Disk size (MB) must be a positive integer."
  }
}

variable "authorized_keys" {
  description = "A list of public SSH keys that will be automatically appended to the root user's ~/.ssh/authorized_keys file when deploying from an Image."
  type        = list(string)
  default     = []
}

variable "authorized_users" {
  description = "A list of usernames. If the usernames have associated SSH keys, the keys will be appended to the root user's ~/.ssh/authorized_keys file."
  type        = list(string)
  default     = []
}

variable "filesystem" {
  description = "The filesystem of this disk. (raw, swap, ext3, ext4, initrd)"
  type        = string
  default     = "ext4"

  validation {
    condition     = contains(["raw", "swap", "ext3", "ext4", "initrd"], var.filesystem)
    error_message = "filesystem must be one of: raw, swap, ext3, ext4, initrd."
  }
}

variable "image" {
  description = "An Image ID to deploy the Linode Disk from."
  type        = string
  default     = null
}

variable "root_pass" {
  description = "The root user's password on a newly-created Linode Disk when deploying from an Image."
  type        = string
  default     = null
}

variable "stackscript_data" {
  description = "An object containing responses to any User Defined Fields present in the StackScript being deployed to this Disk."
  type        = map(any)
  default     = {}
}

variable "stackscript_id" {
  description = "A StackScript ID that will cause the referenced StackScript to be run during deployment of this Disk."
  type        = number
  default     = null

  validation {
    condition     = var.stackscript_id == null || var.stackscript_id > 0
    error_message = "stackscript_id must be a positive integer when set."
  }
}
