output "id" {
  description = "The unique ID of the Linode NodeBalancer."
  value       = linode_nodebalancer.this.id
}

output "label" {
  description = "The label of the Linode NodeBalancer."
  value       = linode_nodebalancer.this.label
}

output "region" {
  description = "The region where this NodeBalancer is deployed."
  value       = linode_nodebalancer.this.region
}

output "hostname" {
  description = "This NodeBalancer's hostname, ending with .nodebalancer.linode.com."
  value       = linode_nodebalancer.this.hostname
}

output "ipv4" {
  description = "The Public IPv4 Address of this NodeBalancer."
  value       = linode_nodebalancer.this.ipv4
}

output "ipv6" {
  description = "The Public IPv6 Address of this NodeBalancer."
  value       = linode_nodebalancer.this.ipv6
}

output "created" {
  description = "When this NodeBalancer was created."
  value       = linode_nodebalancer.this.created
}

output "updated" {
  description = "When this NodeBalancer was last updated."
  value       = linode_nodebalancer.this.updated
}

output "tags" {
  description = "An array of tags applied to this object."
  value       = linode_nodebalancer.this.tags
}

output "transfer" {
  description = "Information about the amount of transfer this NodeBalancer has had so far this month."
  value       = linode_nodebalancer.this.transfer
}
