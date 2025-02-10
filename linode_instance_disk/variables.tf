variable "linode_id" {
  description = "The ID of the Linode to create this Disk under."
  type        = number
}

variable "label" {
  description = "The Disk's label for display purposes only."
  type        = string
}

variable "size" {
  description = "The size of the Disk in MB."
  type        = number
}

variable "authorized_keys" {
  description = "A list of public SSH keys that will be automatically appended to the root user's ~/.ssh/authorized_keys file when deploying from an Image."
  type        = list(string)
  default     = []
}

variable "authorized_users" {
  description = "A list of usernames. If the usernames have associated SSH keys, the keys will be appended to the root user's ~/.ssh/authorized_keys file."
  type        = list(string)
  default     = []
}

variable "filesystem" {
  description = "The filesystem of this disk. (raw, swap, ext3, ext4, initrd)"
  type        = string
  default     = "ext4"
}

variable "image" {
  description = "An Image ID to deploy the Linode Disk from."
  type        = string
  default     = null
}

variable "root_pass" {
  description = "The root user's password on a newly-created Linode Disk when deploying from an Image."
  type        = string
  default     = null
}

variable "stackscript_data" {
  description = "An object containing responses to any User Defined Fields present in the StackScript being deployed to this Disk."
  type        = map(any)
  default     = {}
}

variable "stackscript_id" {
  description = "A StackScript ID that will cause the referenced StackScript to be run during deployment of this Disk."
  type        = number
  default     = null
}
