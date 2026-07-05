output "id" {
  description = "The unique ID of the lock."
  value       = linode_lock.this.id
}

output "entity_id" {
  description = "The ID of the locked entity."
  value       = linode_lock.this.entity_id
}

output "entity_type" {
  description = "The type of the locked entity."
  value       = linode_lock.this.entity_type
}

output "lock_type" {
  description = "The type of lock applied to the entity."
  value       = linode_lock.this.lock_type
}

output "entity_label" {
  description = "The label of the locked entity."
  value       = linode_lock.this.entity_label
}

output "entity_url" {
  description = "The URL of the locked entity."
  value       = linode_lock.this.entity_url
}
