variable "label" {
  description = "The label of the VPC. Only contains ascii letters, digits and dashes"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]*$", var.label))
    error_message = "Label must start with an alphanumeric character and can only contain ascii letters, digits, and dashes."
  }

  validation {
    condition     = length(var.label) >= 1 && length(var.label) <= 64
    error_message = "Label must be between 1 and 64 characters long."
  }
}

variable "region" {
  description = "The region of the VPC."
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

variable "description" {
  description = "The user-defined description of this VPC."
  type        = string
  default     = null

  validation {
    condition     = var.description == null || length(coalesce(var.description, "")) <= 255
    error_message = "Description must be 255 characters or fewer."
  }
}

variable "ipv6" {
  description = "The IPv6 configuration of this VPC."
  type = list(object({
    allocation_class = optional(string)
    range            = optional(string)
  }))
  default = []

  validation {
    condition     = length(var.ipv6) <= 1
    error_message = "At most one ipv6 configuration block may be specified."
  }
}
