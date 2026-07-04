variable "backups_enabled" {
  description = "Account-wide backups default."
  type        = bool
  default     = null
}

variable "network_helper" {
  description = "Enables network helper across all users by default for new Linodes and Linode Configs."
  type        = bool
  default     = null
}

variable "interfaces_for_new_linodes" {
  description = "Type of interfaces for new Linode instances."
  type        = string
  default     = null

  validation {
    condition = var.interfaces_for_new_linodes == null || contains([
      "legacy_config_only",
      "legacy_config_default_but_linode_allowed",
      "linode_default_but_legacy_config_allowed",
      "linode_only",
    ], var.interfaces_for_new_linodes)
    error_message = "Interfaces for new Linodes must be one of: legacy_config_only, legacy_config_default_but_linode_allowed, linode_default_but_legacy_config_allowed, linode_only."
  }
}

variable "maintenance_policy" {
  description = "The default Maintenance Policy for this account. If not provided, the default policy (linode/migrate) will be applied."
  type        = string
  default     = null

  validation {
    condition = var.maintenance_policy == null || contains([
      "linode/migrate",
      "linode/power_off_on",
    ], var.maintenance_policy)
    error_message = "Maintenance policy must be one of: linode/migrate, linode/power_off_on."
  }
}
