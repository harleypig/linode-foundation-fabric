output "id" {
  description = "The unique ID for this IPv6 range."
  value       = linode_ipv6_range.this.id
}

output "range" {
  description = "The IPv6 range of addresses in this pool."
  value       = linode_ipv6_range.this.range
}

output "prefix_length" {
  description = "The prefix length of the IPv6 range."
  value       = linode_ipv6_range.this.prefix_length
}

output "region" {
  description = "The region for this range of IPv6 addresses."
  value       = linode_ipv6_range.this.region
}

output "route_target" {
  description = "The IPv6 SLAAC address this range is assigned to."
  value       = linode_ipv6_range.this.route_target
}

output "is_bgp" {
  description = "Whether this IPv6 range is shared."
  value       = linode_ipv6_range.this.is_bgp
}

output "linodes" {
  description = "A list of Linodes targeted by this IPv6 range, including Linodes with IP sharing."
  value       = linode_ipv6_range.this.linodes
}
