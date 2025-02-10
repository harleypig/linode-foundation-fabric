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

  dynamic "interface" {
    # Create a variable definition suitable for this block at the bottom of the variables.tf file, AI!
    for_each = var.interface
    content {
      purpose      = interface.value.purpose
      ipam_address = lookup(interface.value, "ipam_address", null)
      label        = lookup(interface.value, "label", null)
      subnet_id    = lookup(interface.value, "subnet_id", null)
      primary      = lookup(interface.value, "primary", null)

      dynamic "ipv4" {
        for_each = lookup(interface.value, "ipv4", []) != [] ? [interface.value.ipv4] : []
        content {
          vpc    = lookup(ipv4.value, "vpc", null)
          nat_1_1 = lookup(ipv4.value, "nat_1_1", null)
        }
      }
    }
  }
}
