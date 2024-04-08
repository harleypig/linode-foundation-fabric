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
}

#variable "cpu_alert_threshold" {
#  description = "CPU usage alert threshold."
#  type        = number
#  default     = 90
#}
#
#variable "io_alert_threshold" {
#  description = "IO usage alert threshold."
#  type        = number
#  default     = 10000
#}
#
#variable "network_in_alert_threshold" {
#  description = "Incoming traffic alert threshold in Mbps."
#  type        = number
#  default     = 10
#}
#
#variable "network_out_alert_threshold" {
#  description = "Outgoing traffic alert threshold in Mbps."
#  type        = number
#  default     = 10
#}
#
#variable "transfer_quota_alert_threshold" {
#  description = "Transfer quota alert threshold in percentage."
#  type        = number
#  default     = 80
#}

variable "group" {
  description = "The group this Linode instance will be assigned to."
  type        = string
  default     = ""
}

variable "backups" {
  description = "If this Linode instance should have backups enabled."
  type        = bool
  default     = false
}
