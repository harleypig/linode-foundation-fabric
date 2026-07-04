output "id" {
  description = "The ID of the Linode image."
  value       = linode_image.this.id
}

output "capabilities" {
  description = "The capabilities of this Image."
  value       = linode_image.this.capabilities
}

output "created" {
  description = "When this Image was created."
  value       = linode_image.this.created
}

output "created_by" {
  description = "The name of the User who created this Image."
  value       = linode_image.this.created_by
}

output "deprecated" {
  description = "Whether or not this Image is deprecated. Will only be True for deprecated public Images."
  value       = linode_image.this.deprecated
}

output "expiry" {
  description = "Only Images created automatically (from a deleted Linode; type=automatic) will expire."
  value       = linode_image.this.expiry
}

output "is_public" {
  description = "True if the Image is public."
  value       = linode_image.this.is_public
}

output "is_shared" {
  description = "True if the Image is shared."
  value       = linode_image.this.is_shared
}

output "replications" {
  description = "A list of image replications region and corresponding status."
  value       = linode_image.this.replications
}

output "size" {
  description = "The minimum size this Image needs to deploy. Size is in MB."
  value       = linode_image.this.size
}

output "status" {
  description = "The current status of this Image."
  value       = linode_image.this.status
}

output "total_size" {
  description = "The total size of the image in all available regions."
  value       = linode_image.this.total_size
}

output "type" {
  description = "How the Image was created. 'Manual' Images can be created at any time. 'Automatic' images are created automatically from a deleted Linode."
  value       = linode_image.this.type
}

output "vendor" {
  description = "The upstream distribution vendor. Nil for private Images."
  value       = linode_image.this.vendor
}
