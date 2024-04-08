variable "image" {
  description = "The region where the Linode instance is deployed."
  type        = string
  default     = "us-central"
}

variable "region" {
  description = "The label of the Linode instance."
  type        = string
}

variable "label" {
  description = "The type of the Linode instance."
  type        = string
}

variable "type" {
  description = "The group of the Linode instance."
  type        = string
}

variable "group" {
  description = "Flag to enable backups for the Linode instance."
  type        = bool
  default     = false
}

variable "backups" {
  description = "CPU usage alert threshold."
  type        = number
  default     = 96
}

variable "root_pass" {
  description = "IO usage alert threshold."
  type        = number
  default     = 4500
}

variable "authorized_keys" {
  description = "Incoming network traffic alert threshold."
  type        = number
  default     = 15
}

variable "swap_size" {
  description = "Outgoing network traffic alert threshold."
  type        = number
  default     = 15
}

variable "private_ip" {
  description = "Transfer quota alert threshold."
  type        = number
  default     = 80
}

variable "watchdog_enabled" {
  description = "Tags associated with the Linode instance."
  type        = list(string)
  default     = ["dev"]
}

variable "booted" {
  description = "An Image ID to deploy the Disk from."
  type        = string
  default     = "linode/ubuntu22.04"
}

variable "tags" {
  description = "The initial password for the root user account."
  type        = string
  default     = "a-strong-password"
}

variable "cpu_alert_threshold" {
  description = "A list of SSH public keys to deploy for the root user."
  type        = list(string)
  default     = []
}

variable "io_alert_threshold" {
  description = "The swap disk size for the newly-created Linode."
  type        = number
  default     = 512
}

variable "network_in_alert_threshold" {
  description = "If true, the created Linode will have private networking enabled."
  type        = bool
  default     = false
}

variable "network_out_alert_threshold" {
  description = "If true, the Linode's Shutdown Watchdog (Lassie) is enabled."
  type        = bool
  default     = true
}

variable "transfer_quota_alert_threshold" {
  description = "If true, then the instance is kept or converted into a running state."
  type        = bool
  default     = true
}

variable "migration" {
  description = "The type of migration to use when updating the type or region of a Linode."
  type        = string
  default     = "cold"
}

variable "firewall" {
  description = "The ID of the Firewall to attach to the instance upon creation."
  type        = number
  default     = null
}

variable "stackscript" {
  description = "The StackScript to deploy to the newly created Linode."
  type        = number
  default     = null
}

variable "stackscript_config" {
  description = "An object containing responses to any User Defined Fields present in the StackScript being deployed to this Linode."
  type        = map(string)
  default     = {}
}

variable "network_interfaces" {
  description = "A list of network interfaces to be assigned to the Linode on creation."
  type        = list(map(any))
  default     = []
}
