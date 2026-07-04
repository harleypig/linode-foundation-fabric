output "id" {
  description = "The id of the VPC Subnet."
  value       = linode_vpc_subnet.this.id
}

output "label" {
  description = "The label of the VPC subnet."
  value       = linode_vpc_subnet.this.label
}

output "vpc_id" {
  description = "The id of the parent VPC for this VPC Subnet."
  value       = linode_vpc_subnet.this.vpc_id
}

output "ipv4" {
  description = "The IPv4 range of this subnet in CIDR format."
  value       = linode_vpc_subnet.this.ipv4
}

output "ipv6" {
  description = "The IPv6 ranges of this subnet, including the computed allocated_range for each entry."
  value       = linode_vpc_subnet.this.ipv6
}

output "created" {
  description = "The date and time when the VPC Subnet was created."
  value       = linode_vpc_subnet.this.created
}

output "updated" {
  description = "The date and time when the VPC Subnet was updated."
  value       = linode_vpc_subnet.this.updated
}

output "linodes" {
  description = "A list of Linodes (and their interfaces) currently assigned to this VPC Subnet."
  value       = linode_vpc_subnet.this.linodes
}

output "nodebalancers" {
  description = "A list of NodeBalancers currently assigned to this VPC Subnet."
  value       = linode_vpc_subnet.this.nodebalancers
}

output "databases" {
  description = "A list of databases currently assigned to this VPC Subnet."
  value       = linode_vpc_subnet.this.databases
}
