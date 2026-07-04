resource "linode_image" "this" {
  label       = var.label
  description = var.description
  cloud_init  = var.cloud_init

  disk_id   = var.disk_id
  linode_id = var.linode_id

  file_path = var.file_path
  file_hash = var.file_hash

  region          = var.region
  replica_regions = var.replica_regions

  tags                  = var.tags
  wait_for_replications = var.wait_for_replications

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []
    content {
      create = timeouts.value.create
    }
  }
}
