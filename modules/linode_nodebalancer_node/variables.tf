variable "address" {
  description = "The private IP Address and port (IP:PORT) where this backend can be reached. This must be a private IP address."
  type        = string

  validation {
    condition     = can(regex("^[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}:[0-9]{1,5}$", var.address))
    error_message = "Address must be in the form IP:PORT (e.g. 192.168.1.100:80)."
  }
}

variable "config_id" {
  description = "The ID of the NodeBalancerConfig to access."
  type        = number

  validation {
    condition     = var.config_id > 0
    error_message = "Config ID must be a positive integer."
  }
}

variable "nodebalancer_id" {
  description = "The ID of the NodeBalancer to access."
  type        = number

  validation {
    condition     = var.nodebalancer_id > 0
    error_message = "NodeBalancer ID must be a positive integer."
  }
}

variable "label" {
  description = "The label for this node. This is for display purposes only."
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

variable "mode" {
  description = "The mode this NodeBalancer should use when sending traffic to this backend. If set to `accept` this backend is accepting traffic. If set to `reject` this backend will not receive traffic. If set to `drain` this backend will not receive new traffic, but connections already pinned to it will continue to be routed to it. If set to `backup` this backend will only accept traffic if all other nodes are down."
  type        = string
  default     = null

  validation {
    condition     = var.mode == null || contains(["accept", "reject", "drain", "backup"], coalesce(var.mode, "accept"))
    error_message = "Mode must be one of: accept, reject, drain, backup."
  }
}

variable "weight" {
  description = "Used when picking a backend to serve a request and is not pinned to a single backend yet. Nodes with a higher weight will receive more traffic. (1-255)"
  type        = number
  default     = null

  validation {
    condition     = var.weight == null || (var.weight >= 1 && var.weight <= 255)
    error_message = "Weight must be between 1 and 255 when specified."
  }
}

variable "subnet_id" {
  description = "The ID of the VPC subnet for this node."
  type        = number
  default     = null

  validation {
    condition     = var.subnet_id == null || var.subnet_id > 0
    error_message = "Subnet ID must be a positive integer when specified."
  }
}
