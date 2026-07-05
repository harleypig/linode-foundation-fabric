variable "entity_id" {
  description = "The ID of the entity to lock (a Linode, NodeBalancer, Block Storage volume, LKE cluster, or LKE node pool)."
  type        = number

  validation {
    condition     = var.entity_id > 0
    error_message = "Entity ID must be a positive integer."
  }
}

variable "entity_type" {
  description = "The type of the entity to lock. Note: a Linode that is part of an LKE cluster cannot be locked."
  type        = string

  validation {
    condition     = contains(["linode", "nodebalancer", "volume", "lkecluster", "lkenodepool"], var.entity_type)
    error_message = "Entity type must be one of: linode, nodebalancer, volume, lkecluster, lkenodepool."
  }
}

variable "lock_type" {
  description = "The type of lock to apply. `cannot_delete` prevents deletion, rebuild, and account transfer; `cannot_delete_with_subresources` additionally protects subresources (disks, configs, interfaces, IP addresses) but does NOT apply to an lkecluster or lkenodepool. Only one lock can exist per resource at a time."
  type        = string

  validation {
    condition     = contains(["cannot_delete", "cannot_delete_with_subresources"], var.lock_type)
    error_message = "Lock type must be one of: cannot_delete, cannot_delete_with_subresources."
  }
}
