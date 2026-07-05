resource "linode_lock" "this" {
  entity_id   = var.entity_id
  entity_type = var.entity_type
  lock_type   = var.lock_type
}
