variable "label" {
  description = "The label of the Linode NodeBalancer."
  type        = string
  default     = null

  validation {
    condition     = var.label == null || can(regex("^[a-zA-Z0-9][a-zA-Z0-9_-]*$", coalesce(var.label, "x")))
    error_message = "Label must start with an alphanumeric character and can only contain alphanumeric characters, hyphens, and underscores."
  }

  validation {
    condition     = var.label == null || (length(coalesce(var.label, "")) >= 3 && length(coalesce(var.label, "")) <= 32)
    error_message = "Label must be between 3 and 32 characters long."
  }
}

variable "region" {
  description = "The region where this NodeBalancer will be deployed."
  type        = string
  default     = null

  validation {
    condition = var.region == null || contains([
      "ap-west", "ca-central", "ap-southeast", "us-central", "us-west",
      "us-southeast", "us-east", "eu-west", "ap-south", "eu-central",
      "ap-northeast"
    ], coalesce(var.region, "x"))
    error_message = "Region must be a valid Linode region."
  }
}

variable "client_conn_throttle" {
  description = "Throttle connections per second (0-20). Set to 0 (zero) to disable throttling."
  type        = number
  default     = null

  validation {
    condition     = var.client_conn_throttle == null || (var.client_conn_throttle >= 0 && var.client_conn_throttle <= 20)
    error_message = "client_conn_throttle must be between 0 and 20."
  }
}

variable "client_udp_sess_throttle" {
  description = "Throttle UDP sessions per second (0-20). Set to 0 (zero) to disable throttling."
  type        = number
  default     = null

  validation {
    condition     = var.client_udp_sess_throttle == null || (var.client_udp_sess_throttle >= 0 && var.client_udp_sess_throttle <= 20)
    error_message = "client_udp_sess_throttle must be between 0 and 20."
  }
}

variable "firewall_id" {
  description = "ID for the firewall you'd like to use with this NodeBalancer."
  type        = number
  default     = null

  validation {
    condition     = var.firewall_id == null || var.firewall_id > 0
    error_message = "Firewall ID must be a positive integer when specified."
  }
}

variable "tags" {
  description = "An array of tags applied to this object. Tags are for organizational purposes only."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.tags) <= 64
    error_message = "A maximum of 64 tags can be applied to a NodeBalancer."
  }

  validation {
    condition = alltrue([
      for tag in var.tags : can(regex("^[a-zA-Z0-9:_-]+$", tag)) && length(tag) >= 3 && length(tag) <= 50
    ])
    error_message = "Each tag must be 3-50 characters long and contain only alphanumeric characters, colons, hyphens, and underscores."
  }
}

variable "vpcs" {
  description = "A list of VPCs to be assigned to this NodeBalancer."
  type = list(object({
    subnet_id  = number
    ipv4_range = optional(string)
    ipv6_range = optional(string)
  }))
  default = null

  validation {
    condition     = var.vpcs == null || alltrue([for v in var.vpcs : v.subnet_id > 0])
    error_message = "Each VPC subnet_id must be a positive integer."
  }
}
