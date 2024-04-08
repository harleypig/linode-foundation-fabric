variable "instance_label" {
  description = "The label of the Linode instance."
  type        = string
}

variable "instance_region" {
  description = "The region where the Linode instance is deployed."
  type        = string
  default     = "us-central"
}

variable "instance_type" {
  description = "The type of the Linode instance."
  type        = string
}

variable "instance_group" {
  description = "The group of the Linode instance."
  type        = string
}

variable "backups_enabled" {
  description = "Flag to enable backups for the Linode instance."
  type        = bool
  default     = false
}

variable "alert_cpu" {
  description = "CPU usage alert threshold."
  type        = number
  default     = 96
}

variable "alert_io" {
  description = "IO usage alert threshold."
  type        = number
  default     = 4500
}

variable "alert_network_in" {
  description = "Incoming network traffic alert threshold."
  type        = number
  default     = 15
}

variable "alert_network_out" {
  description = "Outgoing network traffic alert threshold."
  type        = number
  default     = 15
}

variable "alert_transfer_quota" {
  description = "Transfer quota alert threshold."
  type        = number
  default     = 80
}

variable "instance_tags" {
  description = "Tags associated with the Linode instance."
  type        = list(string)
  default     = ["dev"]
}
