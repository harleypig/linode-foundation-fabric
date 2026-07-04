output "id" {
  description = "The id of the PostgreSQL Database."
  value       = linode_database_postgresql_v2.this.id
}

output "status" {
  description = "The operating status of the Managed Database."
  value       = linode_database_postgresql_v2.this.status
}

output "engine" {
  description = "The Managed Database engine in engine/version format."
  value       = linode_database_postgresql_v2.this.engine
}

output "version" {
  description = "The Managed Database engine version."
  value       = linode_database_postgresql_v2.this.version
}

output "platform" {
  description = "The back-end platform for relational databases used by the service."
  value       = linode_database_postgresql_v2.this.platform
}

output "host_primary" {
  description = "The primary host for the Managed Database."
  value       = linode_database_postgresql_v2.this.host_primary
}

output "host_standby" {
  description = "The standby host for the Managed Database."
  value       = linode_database_postgresql_v2.this.host_standby
}

output "port" {
  description = "The access port for this Managed Database."
  value       = linode_database_postgresql_v2.this.port
}

output "ssl_connection" {
  description = "Whether to require SSL credentials to establish a connection to the Managed Database."
  value       = linode_database_postgresql_v2.this.ssl_connection
}

output "encrypted" {
  description = "Whether the Managed Database is encrypted."
  value       = linode_database_postgresql_v2.this.encrypted
}

output "members" {
  description = "A mapping between IP addresses and strings designating them as primary or failover."
  value       = linode_database_postgresql_v2.this.members
}

output "created" {
  description = "When this Managed Database was created."
  value       = linode_database_postgresql_v2.this.created
}

output "updated" {
  description = "When this Managed Database was last updated."
  value       = linode_database_postgresql_v2.this.updated
}

output "oldest_restore_time" {
  description = "The oldest time to which a database can be restored."
  value       = linode_database_postgresql_v2.this.oldest_restore_time
}

output "pending_updates" {
  description = "A set of pending updates."
  value       = linode_database_postgresql_v2.this.pending_updates
}

output "root_username" {
  description = "The root username for the Managed Database instance."
  value       = linode_database_postgresql_v2.this.root_username
  sensitive   = true
}

output "root_password" {
  description = "The randomly generated root password for the Managed Database instance."
  value       = linode_database_postgresql_v2.this.root_password
  sensitive   = true
}

output "ca_cert" {
  description = "The base64-encoded SSL CA certificate for the Managed Database."
  value       = linode_database_postgresql_v2.this.ca_cert
  sensitive   = true
}
