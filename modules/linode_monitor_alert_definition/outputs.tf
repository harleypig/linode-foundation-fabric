output "id" {
  description = "The unique identifier assigned to the alert definition."
  value       = linode_monitor_alert_definition.this.id
}

output "type" {
  description = "The type of alert, either user (specific to the current user) or system (applies to all users on the account)."
  value       = linode_monitor_alert_definition.this.type
}

output "status" {
  description = "The current status of the alert."
  value       = linode_monitor_alert_definition.this.status
}

output "class" {
  description = "The plan type for the Managed Database cluster (only for dbaas system alerts; null otherwise)."
  value       = linode_monitor_alert_definition.this.class
}

output "created" {
  description = "When this Alert Definition was created."
  value       = linode_monitor_alert_definition.this.created
}

output "created_by" {
  description = "The user that created the alert definition, or system for a system alert definition."
  value       = linode_monitor_alert_definition.this.created_by
}

output "updated" {
  description = "When this Alert Definition was last updated."
  value       = linode_monitor_alert_definition.this.updated
}

output "updated_by" {
  description = "The user that last updated the alert definition, or system for a system alert definition."
  value       = linode_monitor_alert_definition.this.updated_by
}

output "alert_channels" {
  description = "The alert channels set up for use with this alert."
  value       = linode_monitor_alert_definition.this.alert_channels
}

output "entities" {
  description = "Entity metadata for the alert definition."
  value       = linode_monitor_alert_definition.this.entities
}
