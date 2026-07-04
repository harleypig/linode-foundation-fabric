output "id" {
  description = "The unique ID of this LKE cluster."
  value       = linode_lke_cluster.this.id
}

output "label" {
  description = "The unique label for the cluster."
  value       = linode_lke_cluster.this.label
}

output "region" {
  description = "This cluster's location."
  value       = linode_lke_cluster.this.region
}

output "k8s_version" {
  description = "The Kubernetes version deployed for this cluster."
  value       = linode_lke_cluster.this.k8s_version
}

output "tier" {
  description = "The Kubernetes tier of the cluster."
  value       = linode_lke_cluster.this.tier
}

output "stack_type" {
  description = "The networking stack type of the Kubernetes cluster."
  value       = linode_lke_cluster.this.stack_type
}

output "status" {
  description = "The status of the cluster."
  value       = linode_lke_cluster.this.status
}

output "api_endpoints" {
  description = "The API endpoints for the cluster."
  value       = linode_lke_cluster.this.api_endpoints
}

output "pool" {
  description = "The node pools in the cluster, including computed node details."
  value       = linode_lke_cluster.this.pool
}

output "kubeconfig" {
  description = "The Base64-encoded Kubeconfig for the cluster."
  value       = linode_lke_cluster.this.kubeconfig
  sensitive   = true
}
