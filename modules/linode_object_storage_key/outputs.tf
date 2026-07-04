output "id" {
  description = "The unique ID of this Object Storage key."
  value       = linode_object_storage_key.this.id
}

output "access_key" {
  description = "This keypair's access key. This is not secret."
  value       = linode_object_storage_key.this.access_key
}

output "secret_key" {
  description = "This keypair's secret key."
  value       = linode_object_storage_key.this.secret_key
  sensitive   = true
}

output "limited" {
  description = "Whether or not this key is a limited access key."
  value       = linode_object_storage_key.this.limited
}

output "regions" {
  description = "The set of regions where the key grants access to create buckets."
  value       = linode_object_storage_key.this.regions
}

output "regions_details" {
  description = "A set of objects containing the detailed info of the regions where the key grants access."
  value       = linode_object_storage_key.this.regions_details
}
