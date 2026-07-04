variable "linode_id" {
  description = "The ID of the Linode to allocate an IPv4 address for. Required when reserved is false or not set."
  type        = number
  default     = null

  validation {
    condition     = var.linode_id == null || var.linode_id > 0
    error_message = "Linode ID must be a positive integer when specified."
  }
}

variable "public" {
  description = "Whether the IPv4 address is public or private."
  type        = bool
  default     = null
}

variable "region" {
  description = "The region for the reserved IPv4 address. Required when reserved is true and linode_id is not set."
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

variable "reserved" {
  description = "Whether the IPv4 address should be reserved."
  type        = bool
  default     = null
}

variable "type" {
  description = "The type of IP address (ipv4)."
  type        = string
  default     = null

  validation {
    condition     = var.type == null || contains(["ipv4"], var.type)
    error_message = "Type must be ipv4."
  }
}
