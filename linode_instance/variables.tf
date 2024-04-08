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

variable "image" {
  description = "An Image ID to deploy the Disk from."
  type        = string
  default     = "linode/ubuntu22.04"
}

variable "root_pass" {
  description = "The initial password for the root user account."
  type        = string
  default     = "a-strong-password"
}

variable "authorized_keys" {
  description = "A list of SSH public keys to deploy for the root user."
  type        = list(string)
  default     = []
}

variable "swap_size" {
  description = "The swap disk size for the newly-created Linode."
  type        = number
  default     = 512
}

variable "private_ip" {
  description = "If true, the created Linode will have private networking enabled."
  type        = bool
  default     = false
}

variable "watchdog_enabled" {
  description = "If true, the Linode's Shutdown Watchdog (Lassie) is enabled."
  type        = bool
  default     = true
}

variable "booted" {
  description = "If true, then the instance is kept or converted into a running state."
  type        = bool
  default     = true
}

variable "migration_type" {
  description = "The type of migration to use when updating the type or region of a Linode."
  type        = string
  default     = "cold"
}

variable "firewall_id" {
  description = "The ID of the Firewall to attach to the instance upon creation."
  type        = number
  default     = null
}

variable "stackscript_id" {
  description = "The StackScript to deploy to the newly created Linode."
  type        = number
  default     = null
}

variable "stackscript_data" {
  description = "An object containing responses to any User Defined Fields present in the StackScript being deployed to this Linode."
  type        = map(string)
  default     = {}
}

variable "interfaces" {
  description = "A list of network interfaces to be assigned to the Linode on creation."
  type        = list(map(any))
  default     = []
}
