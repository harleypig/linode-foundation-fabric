output "id" {
  description = "The ID of the IPv4 address."
  value       = linode_networking_ip.this.id
}

output "address" {
  description = "The allocated IPv4 address."
  value       = linode_networking_ip.this.address
}

output "gateway" {
  description = "The default gateway for this address."
  value       = linode_networking_ip.this.gateway
}

output "prefix" {
  description = "The number of bits set in the subnet mask."
  value       = linode_networking_ip.this.prefix
}

output "rdns" {
  description = "The reverse DNS assigned to this address. For public IPv4 addresses, this will be set to a default value provided by Linode."
  value       = linode_networking_ip.this.rdns
}

output "subnet_mask" {
  description = "The mask that separates host bits from network bits for this address."
  value       = linode_networking_ip.this.subnet_mask
}

output "linode_id" {
  description = "The ID of the Linode this IPv4 address is allocated for."
  value       = linode_networking_ip.this.linode_id
}

output "public" {
  description = "Whether the IPv4 address is public or private."
  value       = linode_networking_ip.this.public
}

output "region" {
  description = "The region of the reserved IPv4 address."
  value       = linode_networking_ip.this.region
}

output "reserved" {
  description = "Whether the IPv4 address is reserved."
  value       = linode_networking_ip.this.reserved
}

output "type" {
  description = "The type of IP address (ipv4)."
  value       = linode_networking_ip.this.type
}

output "vpc_nat_1_1" {
  description = "Information about the NAT 1:1 mapping of a public IP address to a VPC subnet."
  value       = linode_networking_ip.this.vpc_nat_1_1
}
