resource "linode_volume" "this" {
  label     = var.label
  size      = var.size
  region    = var.region
  linode_id = var.linode_id
  tags      = var.tags

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []
    content {
      create = timeouts.value.create
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
