output "id" {
  description = "The ID of this resource (the linode_id of the target Linode)."
  value       = linode_instance_shared_ips.this.id
}

output "linode_id" {
  description = "The ID of the Linode the IP addresses are shared with."
  value       = linode_instance_shared_ips.this.linode_id
}

output "addresses" {
  description = "The set of IP addresses shared to the Linode."
  value       = linode_instance_shared_ips.this.addresses
}
