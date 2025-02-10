# The 'devices' block is deprecated and replaced by the 'device' block.

# Define the following variables, AI!
# * interface
# * kernel

variable "linode_id" {
  description = "The ID of the Linode to create this configuration profile under."
  type        = number
}

variable "label" {
  description = "The Config’s label for display purposes only."
  type        = string
}

variable "booted" {
  description = "If true, the Linode will be booted into this config."
  type        = bool
  default     = false
}

variable "comments" {
  description = "Optional field for arbitrary User comments on this Config."
  type        = string
  default     = null
}

variable "helpers" {
  description = "Helpers enabled when booting to this Linode Config."
  type        = map(bool)
  default     = {
    devtmpfs_automount = true,
    distro             = true,
    modules_dep        = true,
    network            = true,
    updatedb_disabled  = true
  }
}

variable "memory_limit" {
  description = "The memory limit of the Config. Defaults to the total ram of the Linode."
  type        = number
  default     = null
}

variable "root_device" {
  description = "The root device to boot. (default /dev/sda)"
  type        = string
  default     = "/dev/sda"
}

variable "run_level" {
  description = "Defines the state of your Linode after booting. (default, single, binbash)"
  type        = string
  default     = "default"
}

variable "virt_mode" {
  description = "Controls the virtualization mode. (paravirt, fullvirt)"
  type        = string
  default     = "paravirt"
}
