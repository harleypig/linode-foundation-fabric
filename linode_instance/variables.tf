variable "region" {
  description = "The location where the Linode is deployed."
  type        = string
}

variable "type" {
  description = "The Linode type defines the pricing, CPU, disk, and RAM specs of the instance."
  type        = string
}

variable "label" {
  description = "The Linode's label for display purposes."
  type        = string
  default     = null
}

variable "tags" {
  description = "A list of tags applied to this object."
  type        = list(string)
  default     = []
}

variable "private_ip" {
  description = "If true, the created Linode will have private networking enabled."
  type        = bool
  default     = false
}

variable "placement_group_externally_managed" {
  description = "If true, changes to the Linode's assigned Placement Group will be ignored."
  type        = bool
  default     = false
}

variable "shared_ipv4" {
  description = "A set of IPv4 addresses to be shared with the Instance."
  type        = list(string)
  default     = []
}

variable "image" {
  description = "An Image ID to deploy the Disk from."
  type        = string
  default     = null
}

variable "root_pass" {
  description = "The initial password for the root user account."
  type        = string
  default     = null
}

variable "authorized_keys" {
  description = "A list of SSH public keys to deploy for the root user."
  type        = list(string)
  default     = []
}

variable "swap_size" {
  description = "The swap disk size for the newly-created Linode."
  type        = number
  default     = 512
}
