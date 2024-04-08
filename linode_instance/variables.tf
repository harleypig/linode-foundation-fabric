variable "label" {
  description = "The label of the Linode instance."
  type        = string
}

variable "region" {
  description = "The region where the Linode instance will be created."
  type        = string
}

variable "type" {
  description = "The type of the Linode instance (determines the pricing and specifications)."
  type        = string
}

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

variable "cpu_alert_threshold" {
  description = "CPU usage alert threshold."
  type        = number
  default     = 90
}

variable "io_alert_threshold" {
  description = "IO usage alert threshold."
  type        = number
  default     = 10000
}

variable "network_in_alert_threshold" {
  description = "Incoming traffic alert threshold in Mbps."
  type        = number
  default     = 10
}

variable "network_out_alert_threshold" {
  description = "Outgoing traffic alert threshold in Mbps."
  type        = number
  default     = 10
}

variable "transfer_quota_alert_threshold" {
  description = "Transfer quota alert threshold in percentage."
  type        = number
  default     = 80
}

variable "tags" {
  description = "A list of tags to apply to the Linode instance."
  type        = list(string)
  default     = []
}
