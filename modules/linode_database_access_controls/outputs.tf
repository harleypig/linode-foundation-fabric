output "id" {
  description = "The unique ID of this database access controls resource."
  value       = linode_database_access_controls.this.id
}

output "database_id" {
  description = "The ID of the database the allow list is managed for."
  value       = linode_database_access_controls.this.database_id
}

output "database_type" {
  description = "The type of the database the allow list is managed for."
  value       = linode_database_access_controls.this.database_type
}

output "allow_list" {
  description = "The list of IP addresses and CIDR ranges permitted to access the Managed Database."
  value       = linode_database_access_controls.this.allow_list
}
