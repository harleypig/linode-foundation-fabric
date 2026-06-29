# The 'devices' block is deprecated and replaced by the 'device' block.

variable "linode_id" {
  description = "The ID of the Linode to create this configuration profile under."
  type        = number

  validation {
    condition     = var.linode_id > 0
    error_message = "Linode ID must be a positive integer."
  }
}

variable "label" {
  description = "The Config’s label for display purposes only."
  type        = string

  validation {
    condition     = length(var.label) >= 1 && length(var.label) <= 48 && can(regex("^[a-zA-Z0-9][a-zA-Z0-9._-]*$", var.label))
    error_message = "Label must be 1-48 chars, start alphanumeric, and contain only letters, digits, dots, hyphens, underscores."
  }
}

variable "booted" {
  description = "If true, the Linode will be booted into this config."
  type        = bool
  default     = true
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

  validation {
    condition     = var.memory_limit == null || var.memory_limit >= 0
    error_message = "memory_limit must be >= 0 (0 means use the Linode's full RAM)."
  }
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

  validation {
    condition     = contains(["default", "single", "binbash"], var.run_level)
    error_message = "run_level must be one of: default, single, binbash."
  }
}

variable "virt_mode" {
  description = "Controls the virtualization mode. (paravirt, fullvirt)"
  type        = string
  default     = null

  validation {
    condition     = var.virt_mode == null || contains(["paravirt", "fullvirt"], var.virt_mode)
    error_message = "virt_mode must be paravirt or fullvirt."
  }
}

variable "helpers" {
  description = "Helpers enabled when booting to this Linode Config."
  type        = map(bool)
  default     = {}
}

variable "devices" {
  description = "A list of device configurations for the Linode instance."
  type = list(object({
    device_name = string
    disk_id     = optional(number)
    volume_id   = optional(number)
  }))
  default = []

  validation {
    condition     = alltrue([for d in var.devices : contains(["sda", "sdb", "sdc", "sdd", "sde", "sdf", "sdg", "sdh"], d.device_name)])
    error_message = "Each device device_name must be one of sda..sdh."
  }
}

variable "interface" {
  description = "An array of Network Interfaces to use for this Configuration Profile."
  type = list(object({
    purpose      = string
    ipam_address = optional(string)
    label        = optional(string)
    subnet_id    = optional(string)
    primary      = optional(bool)
    ipv4 = optional(object({
      vpc     = optional(string)
      nat_1_1 = optional(string)
    }))
  }))
  default = []

  validation {
    condition     = alltrue([for i in var.interface : contains(["public", "vlan", "vpc"], i.purpose)])
    error_message = "Each interface purpose must be one of: public, vlan, vpc."
  }
}
