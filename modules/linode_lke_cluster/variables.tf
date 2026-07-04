variable "label" {
  description = "The unique label for the cluster."
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

variable "region" {
  description = "This cluster's location."
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

variable "k8s_version" {
  description = "The desired Kubernetes version for this Kubernetes cluster in the format of <major>.<minor>. The latest supported patch version will be deployed."
  type        = string

  validation {
    condition     = can(regex("^[0-9]+\\.[0-9]+$", var.k8s_version))
    error_message = "k8s_version must be in the format <major>.<minor> (e.g. \"1.32\")."
  }
}

variable "tier" {
  description = "The desired Kubernetes tier."
  type        = string
  default     = null

  validation {
    condition     = var.tier == null || contains(["standard", "enterprise"], coalesce(var.tier, "standard"))
    error_message = "tier must be either standard or enterprise."
  }
}

variable "stack_type" {
  description = "The networking stack type of the Kubernetes cluster."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "The ID of the VPC subnet to use for the Kubernetes cluster. This subnet must be dual stack (IPv4 and IPv6 should both be enabled)."
  type        = number
  default     = null

  validation {
    condition     = var.subnet_id == null || coalesce(var.subnet_id, 1) > 0
    error_message = "subnet_id must be a positive integer when specified."
  }
}

variable "vpc_id" {
  description = "The ID of the VPC to use for the Kubernetes cluster."
  type        = number
  default     = null

  validation {
    condition     = var.vpc_id == null || coalesce(var.vpc_id, 1) > 0
    error_message = "vpc_id must be a positive integer when specified."
  }
}

variable "apl_enabled" {
  description = "Enables the App Platform Layer for this cluster. Note: v4beta only and may not currently be available to all users."
  type        = bool
  default     = null
}

variable "external_pool_tags" {
  description = "An array of tags indicating that node pools having those tags are defined with a separate nodepool resource, rather than inside the current cluster resource."
  type        = set(string)
  default     = []
}

variable "tags" {
  description = "An array of tags applied to this object. Tags are for organizational purposes only."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.tags) <= 64
    error_message = "A maximum of 64 tags can be applied to a cluster."
  }

  validation {
    condition = alltrue([
      for tag in var.tags : can(regex("^[a-zA-Z0-9:_-]+$", tag)) && length(tag) >= 3 && length(tag) <= 50
    ])
    error_message = "Each tag must be 3-50 characters long and contain only alphanumeric characters, colons, hyphens, and underscores."
  }
}

variable "control_plane" {
  description = "Defines settings for the Kubernetes Control Plane, including High Availability and an optional API-server access-control list."
  type = object({
    audit_logs_enabled = optional(bool)
    high_availability  = optional(bool)
    acl = optional(object({
      enabled = optional(bool)
      addresses = optional(object({
        ipv4 = optional(set(string))
        ipv6 = optional(set(string))
      }))
    }))
  })
  default = null
}

variable "pool" {
  description = "The node pools in the cluster. At least one pool is required for standard tier clusters."
  type = list(object({
    type            = string
    count           = optional(number)
    disk_encryption = optional(string)
    firewall_id     = optional(number)
    k8s_version     = optional(string)
    label           = optional(string)
    labels          = optional(map(string))
    tags            = optional(set(string))
    update_strategy = optional(string)
    autoscaler = optional(object({
      min = number
      max = number
    }))
    taint = optional(set(object({
      effect = string
      key    = string
      value  = string
    })))
  }))
  default = []

  validation {
    condition     = alltrue([for p in var.pool : p.type != null && p.type != ""])
    error_message = "Each pool must specify a non-empty Linode type."
  }

  validation {
    condition     = alltrue([for p in var.pool : p.count == null || coalesce(p.count, 0) >= 0])
    error_message = "Each pool count must be zero or greater."
  }

  validation {
    condition     = alltrue([for p in var.pool : p.autoscaler == null || (p.autoscaler.min >= 0 && p.autoscaler.max >= p.autoscaler.min)])
    error_message = "Each pool autoscaler must have min >= 0 and max >= min."
  }

  validation {
    condition     = alltrue([for p in var.pool : p.disk_encryption == null || contains(["enabled", "disabled"], coalesce(p.disk_encryption, "enabled"))])
    error_message = "Each pool disk_encryption must be either enabled or disabled."
  }

  validation {
    condition = alltrue([
      for p in var.pool : p.taint == null || alltrue([
        for t in coalesce(p.taint, []) : contains(["NoSchedule", "PreferNoSchedule", "NoExecute"], t.effect)
      ])
    ])
    error_message = "Each pool taint effect must be one of NoSchedule, PreferNoSchedule, or NoExecute."
  }
}

variable "timeouts" {
  description = "The timeouts configuration for the Linode LKE cluster."
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
