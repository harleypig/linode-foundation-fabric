output "id" {
  description = "The unique ID of this Firewall."
  value       = linode_firewall.this.id
}

output "label" {
  description = "This Firewall's unique label."
  value       = linode_firewall.this.label
}

output "status" {
  description = "The status of the Firewall (e.g. enabled, disabled)."
  value       = linode_firewall.this.status
}

output "disabled" {
  description = "Whether the Firewall's rules are currently not enforced."
  value       = linode_firewall.this.disabled
}

output "inbound_policy" {
  description = "The default behavior for inbound traffic."
  value       = linode_firewall.this.inbound_policy
}

output "outbound_policy" {
  description = "The default behavior for outbound traffic."
  value       = linode_firewall.this.outbound_policy
}

output "linodes" {
  description = "IDs of Linodes this Firewall governs."
  value       = linode_firewall.this.linodes
}

output "nodebalancers" {
  description = "IDs of NodeBalancers this Firewall governs."
  value       = linode_firewall.this.nodebalancers
}

output "devices" {
  description = "The devices (Linodes/NodeBalancers) governed by the Firewall."
  value       = linode_firewall.this.devices
}

output "tags" {
  description = "An array of tags applied to this object."
  value       = linode_firewall.this.tags
}
