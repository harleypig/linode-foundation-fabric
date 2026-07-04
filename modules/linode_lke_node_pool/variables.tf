variable "cluster_id" {
  description = "The ID of the cluster to associate this node pool with."
  type        = number

  validation {
    condition     = var.cluster_id > 0
    error_message = "Cluster ID must be a positive integer."
  }
}

variable "type" {
  description = "The type of node pool."
  type        = string

  validation {
    condition     = can(regex("^g[0-9]+-[a-z0-9-]+$", var.type))
    error_message = "Type must be a valid Linode type (e.g. g6-standard-1)."
  }
}

variable "node_count" {
  description = "The number of nodes in the Node Pool. Leave unset when an autoscaler manages the count."
  type        = number
  default     = null

  validation {
    condition     = var.node_count == null || try(var.node_count >= 1, false)
    error_message = "Node count must be at least 1 when specified."
  }
}

variable "label" {
  description = "The label of the Node Pool."
  type        = string
  default     = null

  validation {
    condition     = var.label == null || can(regex("^[a-zA-Z0-9][a-zA-Z0-9_-]*$", var.label))
    error_message = "Label must start with an alphanumeric character and can only contain alphanumeric characters, hyphens, and underscores."
  }
}

variable "disk_encryption" {
  description = "The disk encryption policy for nodes in this pool."
  type        = string
  default     = null

  validation {
    condition     = var.disk_encryption == null || contains(["enabled", "disabled"], coalesce(var.disk_encryption, "enabled"))
    error_message = "disk_encryption must be either enabled or disabled."
  }
}

variable "firewall_id" {
  description = "The ID of the Firewall to attach to nodes in this node pool."
  type        = number
  default     = null

  validation {
    condition     = var.firewall_id == null || try(var.firewall_id > 0, false)
    error_message = "Firewall ID must be a positive integer when specified."
  }
}

variable "k8s_version" {
  description = "The k8s version of the nodes in this node pool. For LKE enterprise only and may not currently be available to all users."
  type        = string
  default     = null
}

variable "update_strategy" {
  description = "The strategy for updating the node pool k8s version. For LKE enterprise only and may not currently be available to all users."
  type        = string
  default     = null

  validation {
    condition     = var.update_strategy == null || contains(["rolling_update", "on_recreate"], coalesce(var.update_strategy, "rolling_update"))
    error_message = "update_strategy must be either rolling_update or on_recreate."
  }
}

variable "labels" {
  description = "Key-value pairs added as labels to nodes in the node pool. Labels help classify your nodes and to easily select subsets of objects."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "An array of tags applied to this object. Tags are for organizational purposes only."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.tags) <= 64
    error_message = "A maximum of 64 tags can be applied to a node pool."
  }

  validation {
    condition = alltrue([
      for tag in var.tags : can(regex("^[a-zA-Z0-9:_-]+$", tag)) && length(tag) >= 3 && length(tag) <= 50
    ])
    error_message = "Each tag must be 3-50 characters long and contain only alphanumeric characters, colons, hyphens, and underscores."
  }
}

variable "autoscaler" {
  description = "Autoscaler configuration for the node pool. When set, the pool automatically scales between min and max nodes."
  type = object({
    min = number
    max = number
  })
  default = null

  validation {
    condition     = var.autoscaler == null || try(var.autoscaler.min >= 1, false)
    error_message = "Autoscaler min must be at least 1."
  }

  validation {
    condition     = var.autoscaler == null || try(var.autoscaler.max >= var.autoscaler.min, false)
    error_message = "Autoscaler max must be greater than or equal to min."
  }
}

variable "taints" {
  description = "Kubernetes taints to add to node pool nodes. Taints help control how pods are scheduled onto nodes, specifically allowing them to repel certain pods."
  type = list(object({
    effect = string
    key    = string
    value  = string
  }))
  default = []

  validation {
    condition     = alltrue([for t in var.taints : contains(["NoSchedule", "PreferNoSchedule", "NoExecute"], t.effect)])
    error_message = "Each taint effect must be one of NoSchedule, PreferNoSchedule, or NoExecute."
  }
}
