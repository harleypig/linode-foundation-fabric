# Put these definitions in the same order they appear in the documentation, AI!
variable "region" {
  description = "The location where the Linode is deployed."
  type        = string
}

variable "type" {
  description = "The Linode type defines the pricing, CPU, disk, and RAM specs of the instance."
  type        = string
}

variable "label" {
  description = "The Linode's label for display purposes only."
  type        = string
  default     = null
}

variable "tags" {
  description = "A list of tags applied to this object."
  type        = list(string)
  default     = []
}

variable "image" {
  description = "An Image ID to deploy the Disk from."
  type        = string
  default     = null
}

variable "migration_type" {
  description = "The type of migration to use when updating the type or region of a Linode."
  type        = string
  default     = "cold"
}

variable "resize_disk" {
  description = "If true, changes in Linode type will attempt to upsize or downsize implicitly created disks."
  type        = bool
  default     = false
}

variable "backups" {
  description = "If true, the created Linode will automatically be enrolled in the Linode Backup service."
  type        = bool
  default     = false
}

variable "swap_size" {
  description = "The swap disk size for the newly-created Linode."
  type        = number
  default     = 512
}
