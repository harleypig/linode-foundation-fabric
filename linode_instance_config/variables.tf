# The 'devices' block is deprecated and replaced by the 'device' block.

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

variable "kernel" {
  description = "A Kernel ID to boot a Linode with. Default is linode/latest-64bit."
  type        = string
  default     = "linode/latest-64bit"
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

variable "helpers" {
  description = "Helpers enabled when booting to this Linode Config."
  type        = map(bool)
}

variable "interface" {
  description = "An array of Network Interfaces to use for this Configuration Profile."
  type        = list(object({
    purpose      = string
    ipam_address = optional(string)
    label        = optional(string)
    subnet_id    = optional(string)
    primary      = optional(bool)
    ipv4         = optional(object({
      vpc    = optional(string)
      nat_1_1 = optional(string)
    }))
  }))
  default     = []
}
