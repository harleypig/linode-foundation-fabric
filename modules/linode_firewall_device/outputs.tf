output "id" {
  description = "The unique ID that represents the firewall device in the Terraform state."
  value       = linode_firewall_device.this.id
}

output "entity_type" {
  description = "The type of the entity the Firewall device was created for."
  value       = linode_firewall_device.this.entity_type
}

output "created" {
  description = "When this Firewall Device was created."
  value       = linode_firewall_device.this.created
}

output "updated" {
  description = "When this Firewall Device was updated."
  value       = linode_firewall_device.this.updated
}
