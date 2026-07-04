output "id" {
  description = "The unique ID for this interface."
  value       = linode_interface.this.id
}

output "linode_id" {
  description = "The ID of the Linode this interface is assigned to."
  value       = linode_interface.this.linode_id
}

output "firewall_id" {
  description = "ID of the firewall securing this VPC or public interface, if any."
  value       = linode_interface.this.firewall_id
}

output "default_route" {
  description = "Whether the interface serves as the IPv4 and/or IPv6 default route."
  value       = linode_interface.this.default_route
}

output "public" {
  description = "The resolved public interface configuration, including assigned addresses."
  value       = linode_interface.this.public
}

output "vlan" {
  description = "The resolved VLAN interface configuration."
  value       = linode_interface.this.vlan
}

output "vpc" {
  description = "The resolved VPC interface configuration, including assigned addresses and ranges."
  value       = linode_interface.this.vpc
}
