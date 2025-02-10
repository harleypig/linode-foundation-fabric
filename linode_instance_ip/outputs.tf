# This is a module that will be used as a source for a module. How can I make this generic, AI?
output "gateway" {
  description = "The default gateway for this address"
  value       = linode_instance_ip.foo.gateway
}

output "prefix" {
  description = "The number of bits set in the subnet mask."
  value       = linode_instance_ip.foo.prefix
}

output "address" {
  description = "The resulting IPv4 address."
  value       = linode_instance_ip.foo.address
}

output "region" {
  description = "The region this IP resides in."
  value       = linode_instance_ip.foo.region
}

output "subnet_mask" {
  description = "The mask that separates host bits from network bits for this address."
  value       = linode_instance_ip.foo.subnet_mask
}

output "type" {
  description = "The type of IP address. (ipv4, ipv6, ipv6/pool, ipv6/range)"
  value       = linode_instance_ip.foo.type
}
