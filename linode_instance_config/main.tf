resource "linode_instance_config" "this" {
  linode_id    = var.linode_id
  label        = var.label
  booted       = var.booted
  comments     = var.comments
  kernel       = var.kernel
  memory_limit = var.memory_limit
  root_device  = var.root_device
  run_level    = var.run_level
  virt_mode    = var.virt_mode
}
