output "id" {
  description = "The id of the MySQL Database."
  value       = linode_database_mysql_v2.this.id
}

output "status" {
  description = "The operating status of the Managed Database."
  value       = linode_database_mysql_v2.this.status
}

output "engine" {
  description = "The Managed Database engine in engine/version format."
  value       = linode_database_mysql_v2.this.engine
}

output "version" {
  description = "The Managed Database engine version."
  value       = linode_database_mysql_v2.this.version
}

output "encrypted" {
  description = "Whether the Managed Database is encrypted."
  value       = linode_database_mysql_v2.this.encrypted
}

output "host_primary" {
  description = "The primary host for the Managed Database."
  value       = linode_database_mysql_v2.this.host_primary
}

output "host_standby" {
  description = "The standby host for the Managed Database."
  value       = linode_database_mysql_v2.this.host_standby
}

output "port" {
  description = "The access port for this Managed Database."
  value       = linode_database_mysql_v2.this.port
}

output "ssl_connection" {
  description = "Whether to require SSL credentials to establish a connection to the Managed Database."
  value       = linode_database_mysql_v2.this.ssl_connection
}

output "ca_cert" {
  description = "The base64-encoded SSL CA certificate for the Managed Database."
  value       = linode_database_mysql_v2.this.ca_cert
  sensitive   = true
}

output "root_username" {
  description = "The root username for the Managed Database instance."
  value       = linode_database_mysql_v2.this.root_username
  sensitive   = true
}

output "root_password" {
  description = "The randomly generated root password for the Managed Database instance."
  value       = linode_database_mysql_v2.this.root_password
  sensitive   = true
}

output "created" {
  description = "When this Managed Database was created."
  value       = linode_database_mysql_v2.this.created
}

output "updated" {
  description = "When this Managed Database was last updated."
  value       = linode_database_mysql_v2.this.updated
}
