output "id" {
  description = "The StackScript's unique ID."
  value       = linode_stackscript.this.id
}

output "label" {
  description = "The StackScript's label."
  value       = linode_stackscript.this.label
}

output "is_public" {
  description = "Whether other users can use this StackScript."
  value       = linode_stackscript.this.is_public
}

output "created" {
  description = "The date this StackScript was created."
  value       = linode_stackscript.this.created
}

output "updated" {
  description = "The date this StackScript was updated."
  value       = linode_stackscript.this.updated
}

output "deployments_active" {
  description = "Count of currently active, deployed Linodes created from this StackScript."
  value       = linode_stackscript.this.deployments_active
}

output "deployments_total" {
  description = "The total number of times this StackScript has been deployed."
  value       = linode_stackscript.this.deployments_total
}

output "user_defined_fields" {
  description = "A list of fields defined with a special syntax inside this StackScript that allow for supplying customized parameters during deployment."
  value       = linode_stackscript.this.user_defined_fields
}

output "user_gravatar_id" {
  description = "The Gravatar ID for the User who created the StackScript."
  value       = linode_stackscript.this.user_gravatar_id
}

output "username" {
  description = "The User who created the StackScript."
  value       = linode_stackscript.this.username
}
