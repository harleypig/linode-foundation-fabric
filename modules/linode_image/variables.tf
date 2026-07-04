variable "label" {
  description = "A short description of the Image. Labels cannot contain special characters."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9_-]*$", var.label))
    error_message = "Label must start with an alphanumeric character and can only contain alphanumeric characters, hyphens, and underscores."
  }

  validation {
    condition     = length(var.label) >= 1 && length(var.label) <= 50
    error_message = "Label must be between 1 and 50 characters long."
  }
}

variable "description" {
  description = "A detailed description of this Image."
  type        = string
  default     = null
}

variable "cloud_init" {
  description = "Whether this image supports cloud-init."
  type        = bool
  default     = null
}

variable "disk_id" {
  description = "The ID of the Linode Disk that this Image will be created from."
  type        = number
  default     = null

  validation {
    condition     = var.disk_id == null || var.disk_id > 0
    error_message = "Disk ID must be a positive integer when specified."
  }
}

variable "linode_id" {
  description = "The ID of the Linode that this Image will be created from."
  type        = number
  default     = null

  validation {
    condition     = var.linode_id == null || var.linode_id > 0
    error_message = "Linode ID must be a positive integer when specified."
  }
}

variable "region" {
  description = "The region to upload to."
  type        = string
  default     = null

  validation {
    condition = var.region == null || contains([
      "ap-west", "ca-central", "ap-southeast", "us-central", "us-west",
      "us-southeast", "us-east", "eu-west", "ap-south", "eu-central",
      "ap-northeast"
    ], var.region)
    error_message = "Region must be a valid Linode region."
  }
}

variable "replica_regions" {
  description = "A list of regions that customer wants to replicate this image in. At least one available region is required and only core regions allowed. Existing images in the regions not passed will be removed."
  type        = list(string)
  default     = null

  validation {
    condition = var.replica_regions == null || alltrue([
      for r in var.replica_regions : contains([
        "ap-west", "ca-central", "ap-southeast", "us-central", "us-west",
        "us-southeast", "us-east", "eu-west", "ap-south", "eu-central",
        "ap-northeast"
      ], r)
    ])
    error_message = "Each replica region must be a valid Linode region."
  }
}

variable "file_path" {
  description = "The name of the file to upload to this image."
  type        = string
  default     = null
}

variable "file_hash" {
  description = "The MD5 hash of the image file."
  type        = string
  default     = null

  validation {
    condition     = var.file_hash == null || can(regex("^[a-f0-9]{32}$", var.file_hash))
    error_message = "file_hash must be a 32-character hexadecimal MD5 digest."
  }
}

variable "tags" {
  description = "The customized tags for the image."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.tags) <= 64
    error_message = "A maximum of 64 tags can be applied to an image."
  }

  validation {
    condition = alltrue([
      for tag in var.tags : can(regex("^[a-zA-Z0-9:_-]+$", tag)) && length(tag) >= 3 && length(tag) <= 50
    ])
    error_message = "Each tag must be 3-50 characters long and contain only alphanumeric characters, colons, hyphens, and underscores."
  }
}

variable "wait_for_replications" {
  description = "Whether to wait for all image replications become `available`."
  type        = bool
  default     = null
}

variable "timeouts" {
  description = "The timeouts configuration for the Linode image."
  type = object({
    create = optional(string)
  })
  default = null

  validation {
    condition = var.timeouts == null || alltrue([
      for timeout in values(var.timeouts) : timeout == null || can(regex("^[0-9]+[smh]$", timeout))
    ])
    error_message = "Timeout values must be in the format of number followed by 's' (seconds), 'm' (minutes), or 'h' (hours)."
  }
}
