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

  # Ensure there is one or none helpers blocks, AI!
  dynamic "helpers" {
    for_each = var.helpers != {} ? [var.helpers] : []
    content {
      devtmpfs_automount = lookup(helpers.value, "devtmpfs_automount", true)
      distro             = lookup(helpers.value, "distro", true)
      modules_dep        = lookup(helpers.value, "modules_dep", true)
      network            = lookup(helpers.value, "network", true)
      updatedb_disabled  = lookup(helpers.value, "updatedb_disabled", true)
    }
  }
}
