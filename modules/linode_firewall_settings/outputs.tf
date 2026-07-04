output "id" {
  description = "A unique identifier for this resource (UUID v7)."
  value       = linode_firewall_settings.this.id
}

output "default_firewall_ids" {
  description = "The resolved default firewall IDs for the linode, nodebalancer, public_interface, and vpc_interface."
  value       = linode_firewall_settings.this.default_firewall_ids
}

output "linode_default_firewall_id" {
  description = "The Linode's default firewall."
  value       = linode_firewall_settings.this.default_firewall_ids.linode
}

output "nodebalancer_default_firewall_id" {
  description = "The NodeBalancer's default firewall."
  value       = linode_firewall_settings.this.default_firewall_ids.nodebalancer
}

output "public_interface_default_firewall_id" {
  description = "The public interface's default firewall."
  value       = linode_firewall_settings.this.default_firewall_ids.public_interface
}

output "vpc_interface_default_firewall_id" {
  description = "The VPC interface's default firewall."
  value       = linode_firewall_settings.this.default_firewall_ids.vpc_interface
}
