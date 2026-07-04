output "id" {
  description = "The id of the VPC."
  value       = linode_vpc.this.id
}

output "label" {
  description = "The label of the VPC."
  value       = linode_vpc.this.label
}

output "region" {
  description = "The region of the VPC."
  value       = linode_vpc.this.region
}

output "description" {
  description = "The user-defined description of this VPC."
  value       = linode_vpc.this.description
}

output "ipv6" {
  description = "The IPv6 configuration of this VPC, including the allocated range."
  value       = linode_vpc.this.ipv6
}

output "created" {
  description = "The date and time when the VPC was created."
  value       = linode_vpc.this.created
}

output "updated" {
  description = "The date and time when the VPC was updated."
  value       = linode_vpc.this.updated
}
