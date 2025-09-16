variable "label" {
  description = "The label of the Linode Volume."
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

variable "size" {
  description = "Size of the Volume in GB."
  type        = number

  validation {
    condition     = var.size >= 10 && var.size <= 10240
    error_message = "Volume size must be between 10 GB and 10240 GB (10 TB)."
  }
}

variable "region" {
  description = "The region where this volume will be deployed."
  type        = string

  validation {
    condition = contains([
      "ap-west", "ca-central", "ap-southeast", "us-central", "us-west", 
      "us-southeast", "us-east", "eu-west", "ap-south", "eu-central", 
      "ap-northeast"
    ], var.region)
    error_message = "Region must be a valid Linode region."
  }
}

variable "linode_id" {
  description = "The Linode ID to attach the volume to."
  type        = number

  validation {
    condition     = var.linode_id > 0
    error_message = "Linode ID must be a positive integer."
  }
}

variable "tags" {
  description = "An array of tags applied to this object."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.tags) <= 64
    error_message = "A maximum of 64 tags can be applied to a volume."
  }

  validation {
    condition = alltrue([
      for tag in var.tags : can(regex("^[a-zA-Z0-9:_-]+$", tag)) && length(tag) >= 3 && length(tag) <= 50
    ])
    error_message = "Each tag must be 3-50 characters long and contain only alphanumeric characters, colons, hyphens, and underscores."
  }
}

variable "timeouts" {
  description = "The timeouts configuration for the Linode volume."
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null

  validation {
    condition = var.timeouts == null || alltrue([
      for timeout in values(var.timeouts) : timeout == null || can(regex("^[0-9]+[smh]$", timeout))
    ])
    error_message = "Timeout values must be in the format of number followed by 's' (seconds), 'm' (minutes), or 'h' (hours)."
  }
}
