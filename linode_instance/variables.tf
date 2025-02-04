variable "region" {
  description = "The region where the Linode instance will be created."
  type        = string
}

variable "type" {
  description = "The type of the Linode instance (determines the pricing and specifications)."
  type        = string
}

variable "label" {
  description = "The label of the Linode instance."
  type        = string
}

variable "tags" {
  description = "A list of tags to apply to the Linode instance."
  type        = list(string)
  default     = []
}

variable "private_ip" {
  description = "If true, the created Linode will have private networking enabled."
  type        = bool
  default     = false
}

variable "shared_ipv4" {
  description = "A set of IPv4 addresses to be shared with the Instance."
  type        = string
  default     = ""
}

variable "user_data" {
  description = "The base64-encoded user-defined data exposed to this instance through the Linode Metadata service."
  type        = string
  default     = ""
}

variable "resize_disk" {
  description = "If true, changes in Linode type will attempt to upsize or downsize implicitly created disks."
  type        = bool
  default     = false
}

variable "backups" {
  description = "If this Linode instance should have backups enabled."
  type        = bool
  default     = false
}

variable "watchdog" {
  description = "The watchdog will reboot the instance if it powers off unexpectedly."
  type        = bool
  default     = false
}

variable "booted" {
  description = "If true, then the instance is kept or converted into in a running state. If false, the instance will be shutdown."
  type        = bool
  default     = true
}

variable "migration_type" {
  description = "The type of migration ('live' or 'cold') that will occur when the Linode instance is resized."
  type        = string
  default     = "cold"
}

# Simplified Resource Arguments

variable "backup_id" {
  description = "A Backup ID from another Linode's available backups."
  type        = number
  default     = null
}

variable "image" {
  description = "The image to use for the Linode instance."
  type        = string
}

variable "root_pass" {
  description = "The initial password for the root user account."
  type        = string
}

variable "kernel" {
  description = "The kernel to use for the Linode instance."
  type        = string
  default     = "linode/grub2"
}

variable "memory_limit" {
  description = "The memory limit of the Linode instance in MB. Set to 0 for no limit."
  type        = number
  default     = 0
}

variable "root_device" {
  description = "The root device to use for booting the Linode instance."
  type        = string
  default     = "/dev/sda"
}

variable "run_level" {
  description = "The run level ('default', 'single', 'binbash') to boot the Linode instance into."
  type        = string
  default     = "default"
}

variable "virt_mode" {
  description = "The virtualization mode ('fullvirt' or 'paravirt') to use for the Linode instance."
  type        = string
  default     = "paravirt"
}

variable "helpers" {
  description = "A map of helper settings to use for the Linode instance."
  type        = map(bool)
  default = {
    devtmpfs_automount = true
    distro             = true
    modules_dep        = true
    network            = true
    updatedb_disabled  = true
  }
}

# Add a variable description for the swap_size attribute here, AI!