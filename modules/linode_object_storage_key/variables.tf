variable "label" {
  description = "The label given to this key. For display purposes only."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9_-]*$", var.label))
    error_message = "Label must start with an alphanumeric character and can only contain alphanumeric characters, hyphens, and underscores."
  }

  validation {
    condition     = length(var.label) >= 3 && length(var.label) <= 50
    error_message = "Label must be between 3 and 50 characters long."
  }
}

variable "regions" {
  description = "A set of regions where the key will grant access to create buckets."
  type        = set(string)
  default     = null

  validation {
    condition = var.regions == null || alltrue([
      for region in coalesce(var.regions, []) : can(regex("^[a-z]{2}-[a-z0-9]+$", region))
    ])
    error_message = "Each region must be a valid Object Storage region code (e.g. us-east, us-mia)."
  }
}

variable "bucket_access" {
  description = "A list of permissions to grant this limited access key. Providing any bucket_access entries produces a limited access key scoped to those buckets."
  type = list(object({
    bucket_name = string
    permissions = string
    region      = optional(string)
  }))
  default = []

  validation {
    condition     = alltrue([for b in var.bucket_access : contains(["read_only", "read_write"], b.permissions)])
    error_message = "Each bucket_access permissions value must be either read_only or read_write."
  }

  validation {
    condition = alltrue([
      for b in var.bucket_access : b.region == null || can(regex("^[a-z]{2}-[a-z0-9]+$", b.region))
    ])
    error_message = "Each bucket_access region must be a valid Object Storage region code (e.g. us-east, us-mia)."
  }
}
