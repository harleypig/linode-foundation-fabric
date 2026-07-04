output "created" {
  description = "When this disk was created."
  value       = linode_instance_disk.this.created
}

output "disk_encryption" {
  description = "The disk encryption policy for this disk's parent instance."
  value       = linode_instance_disk.this.disk_encryption
}

output "status" {
  description = "A brief description of this Disk's current state."
  value       = linode_instance_disk.this.status
}

output "updated" {
  description = "When this disk was last updated."
  value       = linode_instance_disk.this.updated
}
