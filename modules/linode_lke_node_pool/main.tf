resource "linode_lke_node_pool" "this" {
  cluster_id = var.cluster_id
  type       = var.type
  node_count = var.node_count

  label           = var.label
  disk_encryption = var.disk_encryption
  firewall_id     = var.firewall_id
  k8s_version     = var.k8s_version
  update_strategy = var.update_strategy

  labels = var.labels
  tags   = var.tags

  dynamic "autoscaler" {
    for_each = var.autoscaler != null ? [var.autoscaler] : []
    content {
      min = autoscaler.value.min
      max = autoscaler.value.max
    }
  }

  dynamic "taint" {
    for_each = var.taints
    content {
      effect = taint.value.effect
      key    = taint.value.key
      value  = taint.value.value
    }
  }
}
