output "id" {
  description = "The email of the current account."
  value       = linode_account_settings.this.id
}

output "backups_enabled" {
  description = "Account-wide backups default."
  value       = linode_account_settings.this.backups_enabled
}

output "network_helper" {
  description = "Whether network helper is enabled across all users by default for new Linodes and Linode Configs."
  value       = linode_account_settings.this.network_helper
}

output "interfaces_for_new_linodes" {
  description = "Type of interfaces for new Linode instances."
  value       = linode_account_settings.this.interfaces_for_new_linodes
}

output "maintenance_policy" {
  description = "The default Maintenance Policy for this account."
  value       = linode_account_settings.this.maintenance_policy
}

output "longview_subscription" {
  description = "The Longview Pro tier you are currently subscribed to."
  value       = linode_account_settings.this.longview_subscription
}

output "managed" {
  description = "Whether monitoring for connectivity, response, and total request time is enabled."
  value       = linode_account_settings.this.managed
}

output "object_storage" {
  description = "A string describing the status of this account's Object Storage service enrollment."
  value       = linode_account_settings.this.object_storage
}
