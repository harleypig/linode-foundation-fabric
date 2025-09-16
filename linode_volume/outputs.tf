output "id" {
  description = "The unique ID of this Volume."
  value       = linode_volume.this.id
}

output "label" {
  description = "The label of the Linode Volume."
  value       = linode_volume.this.label
}

output "size" {
  description = "The size of the Volume in GB."
  value       = linode_volume.this.size
}

output "region" {
  description = "The region where this volume resides."
  value       = linode_volume.this.region
}

output "linode_id" {
  description = "If a volume is attached to a specific Linode, the ID of that Linode will be displayed here."
  value       = linode_volume.this.linode_id
}

output "filesystem_path" {
  description = "The full filesystem path for the Volume based on the Volume's label."
  value       = linode_volume.this.filesystem_path
}

output "status" {
  description = "The status of the volume, indicating if it's active or if any action is needed."
  value       = linode_volume.this.status
}

output "tags" {
  description = "An array of tags applied to this object."
  value       = linode_volume.this.tags
}

