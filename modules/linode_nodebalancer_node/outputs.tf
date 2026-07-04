output "id" {
  description = "The ID of the NodeBalancer node resource."
  value       = linode_nodebalancer_node.this.id
}

output "nodebalancer_id" {
  description = "The ID of the NodeBalancer this node is attached to."
  value       = linode_nodebalancer_node.this.nodebalancer_id
}

output "config_id" {
  description = "The ID of the NodeBalancerConfig this node serves."
  value       = linode_nodebalancer_node.this.config_id
}

output "address" {
  description = "The private IP Address and port (IP:PORT) where this backend can be reached."
  value       = linode_nodebalancer_node.this.address
}

output "label" {
  description = "The label for this node."
  value       = linode_nodebalancer_node.this.label
}

output "mode" {
  description = "The mode this NodeBalancer uses when sending traffic to this backend."
  value       = linode_nodebalancer_node.this.mode
}

output "weight" {
  description = "The weight used when picking a backend to serve a request."
  value       = linode_nodebalancer_node.this.weight
}

output "status" {
  description = "The current status of this node, based on the configured checks of its NodeBalancer Config. (unknown, UP, DOWN)"
  value       = linode_nodebalancer_node.this.status
}

output "vpc_config_id" {
  description = "The ID of the NB-VPC config for this node."
  value       = linode_nodebalancer_node.this.vpc_config_id
}
