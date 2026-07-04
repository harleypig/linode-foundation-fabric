output "id" {
  description = "The ID of the IP assignment operation."
  value       = linode_networking_ip_assignment.this.id
}

output "region" {
  description = "The region the IP assignments were applied in."
  value       = linode_networking_ip_assignment.this.region
}
