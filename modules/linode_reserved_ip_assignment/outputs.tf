output "id" {
  description = "The ID of the IPv4 address, which will be the IPv4 address itself."
  value       = linode_reserved_ip_assignment.this.id
}

output "address" {
  description = "The resulting IPv4 address."
  value       = linode_reserved_ip_assignment.this.address
}

output "linode_id" {
  description = "The ID of the Linode this IPv4 address is allocated to."
  value       = linode_reserved_ip_assignment.this.linode_id
}

output "gateway" {
  description = "The default gateway for this address."
  value       = linode_reserved_ip_assignment.this.gateway
}

output "prefix" {
  description = "The number of bits set in the subnet mask."
  value       = linode_reserved_ip_assignment.this.prefix
}

output "public" {
  description = "Whether the IPv4 address is public or private."
  value       = linode_reserved_ip_assignment.this.public
}

output "rdns" {
  description = "The reverse DNS assigned to this address."
  value       = linode_reserved_ip_assignment.this.rdns
}

output "region" {
  description = "The region this IP resides in."
  value       = linode_reserved_ip_assignment.this.region
}

output "reserved" {
  description = "The reservation status of the IP address."
  value       = linode_reserved_ip_assignment.this.reserved
}

output "subnet_mask" {
  description = "The mask that separates host bits from network bits for this address."
  value       = linode_reserved_ip_assignment.this.subnet_mask
}

output "type" {
  description = "The type of IP address."
  value       = linode_reserved_ip_assignment.this.type
}

output "vpc_nat_1_1" {
  description = "Contains information about the NAT 1:1 mapping of a public IP address to a VPC subnet."
  value       = linode_reserved_ip_assignment.this.vpc_nat_1_1
}
