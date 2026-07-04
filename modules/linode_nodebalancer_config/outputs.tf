output "id" {
  description = "The ID of the Linode NodeBalancer Config."
  value       = linode_nodebalancer_config.this.id
}

output "nodebalancer_id" {
  description = "The ID of the NodeBalancer this Config belongs to."
  value       = linode_nodebalancer_config.this.nodebalancer_id
}

output "port" {
  description = "The TCP port this Config is for."
  value       = linode_nodebalancer_config.this.port
}

output "protocol" {
  description = "The protocol this port is configured to serve."
  value       = linode_nodebalancer_config.this.protocol
}

output "ssl_commonname" {
  description = "The read-only common name automatically derived from the SSL certificate assigned to this NodeBalancerConfig."
  value       = linode_nodebalancer_config.this.ssl_commonname
}

output "ssl_fingerprint" {
  description = "The read-only fingerprint automatically derived from the SSL certificate assigned to this NodeBalancerConfig."
  value       = linode_nodebalancer_config.this.ssl_fingerprint
}

output "node_status" {
  description = "A structure containing information about the health of the backends for this port, updated periodically as checks are performed."
  value       = linode_nodebalancer_config.this.node_status
}

output "udp_session_timeout" {
  description = "The read-only idle time in seconds after which a session that hasn't received packets is destroyed."
  value       = linode_nodebalancer_config.this.udp_session_timeout
}
