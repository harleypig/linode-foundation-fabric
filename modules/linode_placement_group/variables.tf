variable "label" {
  description = "The label of the Placement Group."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9._-]*$", var.label))
    error_message = "Label must start with an alphanumeric character and can only contain alphanumeric characters, periods, hyphens, and underscores."
  }

  validation {
    condition     = length(var.label) >= 1 && length(var.label) <= 64
    error_message = "Label must be between 1 and 64 characters long."
  }
}

variable "region" {
  description = "The region of the Placement Group."
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

variable "placement_group_type" {
  description = "The placement group type for Linodes in this Placement Group."
  type        = string

  validation {
    condition     = contains(["anti_affinity:local"], var.placement_group_type)
    error_message = "Placement group type must be one of: anti_affinity:local."
  }
}

variable "placement_group_policy" {
  description = "Whether this Placement Group has a strict compliance policy."
  type        = string
  default     = null

  validation {
    condition     = var.placement_group_policy == null || contains(["strict", "flexible"], var.placement_group_policy)
    error_message = "Placement group policy must be one of: strict, flexible."
  }
}
