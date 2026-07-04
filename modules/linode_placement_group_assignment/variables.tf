variable "placement_group_id" {
  description = "The ID of the Placement Group for this assignment."
  type        = number

  validation {
    condition     = var.placement_group_id > 0
    error_message = "Placement Group ID must be a positive integer."
  }
}

variable "linode_id" {
  description = "A set of Linode IDs to assign to the Placement Group."
  type        = number

  validation {
    condition     = var.linode_id > 0
    error_message = "Linode ID must be a positive integer."
  }
}

variable "compliant_only" {
  description = "When enabled, only Linodes that are compliant with the Placement Group's affinity policy are assigned."
  type        = bool
  default     = null
}
