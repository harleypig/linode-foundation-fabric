output "id" {
  description = "The unique ID of this bucket."
  value       = linode_object_storage_bucket.this.id
}

output "label" {
  description = "The label of the bucket."
  value       = linode_object_storage_bucket.this.label
}

output "region" {
  description = "The region (cluster) the bucket resides in."
  value       = linode_object_storage_bucket.this.region
}

output "hostname" {
  description = "The hostname where this bucket can be accessed (label.region.linodeobjects.com)."
  value       = linode_object_storage_bucket.this.hostname
}

output "s3_endpoint" {
  description = "The S3 endpoint URL for the bucket."
  value       = linode_object_storage_bucket.this.s3_endpoint
}
