variable "region" {
  description = "The region in which to reserve the IP address."
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

variable "tags" {
  description = "Tags applied to this reserved IP address."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.tags) <= 64
    error_message = "A maximum of 64 tags can be applied to a reserved IP address."
  }

  validation {
    condition = alltrue([
      for tag in var.tags : can(regex("^[a-zA-Z0-9:_-]+$", tag)) && length(tag) >= 3 && length(tag) <= 50
    ])
    error_message = "Each tag must be 3-50 characters long and contain only alphanumeric characters, colons, hyphens, and underscores."
  }
}
