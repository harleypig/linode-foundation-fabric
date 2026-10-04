output "id" {
  description = "The ID of the reserved IP address, which is the address itself."
  value       = linode_reserved_ip.this.id
}

output "address" {
  description = "The reserved IPv4 address."
  value       = linode_reserved_ip.this.address
}

output "gateway" {
  description = "The default gateway for this address."
  value       = linode_reserved_ip.this.gateway
}

output "subnet_mask" {
  description = "The mask that separates host bits from network bits for this address."
  value       = linode_reserved_ip.this.subnet_mask
}

output "prefix" {
  description = "The number of bits set in the subnet mask."
  value       = linode_reserved_ip.this.prefix
}

output "type" {
  description = "The type of IP address."
  value       = linode_reserved_ip.this.type
}

output "public" {
  description = "Whether this is a public or private IP address."
  value       = linode_reserved_ip.this.public
}

output "rdns" {
  description = "The reverse DNS assigned to this address."
  value       = linode_reserved_ip.this.rdns
}

output "linode_id" {
  description = "The ID of the Linode this address is currently assigned to, if any."
  value       = linode_reserved_ip.this.linode_id
}

output "reserved" {
  description = "Whether this IP address is reserved."
  value       = linode_reserved_ip.this.reserved
}

output "tags" {
  description = "Tags applied to this reserved IP address."
  value       = linode_reserved_ip.this.tags
}

output "vpc_nat_1_1" {
  description = "Information about the NAT 1:1 mapping of this address to a VPC subnet."
  value       = linode_reserved_ip.this.vpc_nat_1_1
}

output "assigned_entity" {
  description = "The entity this reserved IP address is currently assigned to, if any."
  value       = linode_reserved_ip.this.assigned_entity
}
