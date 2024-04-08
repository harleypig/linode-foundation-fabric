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
  type = string
  default = ""
}

variable "resize_disk" {
  description = "If true, changes in Linode type will attempt to upsize or downsize implicitly created disks."
  type        = bool
  default     = false
}

variable "alert" {
  description = "Alert thresholds for CPU, IO, network, and transfer quota."
  type = object({
    cpu            = number
    io             = number
    network_in     = number
    network_out    = number
    transfer_quota = number
  })
  default = {
    cpu            = 90
    io             = 10000
    network_in     = 10
    network_out    = 10
    transfer_quota = 80
  }
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
