output "id" {
  description = "The unique ID of this Node Pool."
  value       = linode_lke_node_pool.this.id
}

output "label" {
  description = "The label of the Node Pool."
  value       = linode_lke_node_pool.this.label
}

output "type" {
  description = "The type of node pool."
  value       = linode_lke_node_pool.this.type
}

output "node_count" {
  description = "The number of nodes in the Node Pool."
  value       = linode_lke_node_pool.this.node_count
}

output "disk_encryption" {
  description = "The disk encryption policy for nodes in this pool."
  value       = linode_lke_node_pool.this.disk_encryption
}

output "k8s_version" {
  description = "The k8s version of the nodes in this node pool."
  value       = linode_lke_node_pool.this.k8s_version
}

output "nodes" {
  description = "A list of nodes in the node pool, each with its id, instance_id, and status."
  value       = linode_lke_node_pool.this.nodes
}

output "tags" {
  description = "An array of tags applied to this object."
  value       = linode_lke_node_pool.this.tags
}
