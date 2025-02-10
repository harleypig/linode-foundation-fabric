resource "linode_instance" "instance" {
  region          = var.region
  type            = var.type
  label           = var.label
  tags            = var.tags
  private_ip      = var.private_ip
  shared_ipv4     = var.shared_ipv4
  image           = var.image
  root_pass       = var.root_pass
  authorized_keys = var.authorized_keys
  authorized_users = var.authorized_users
  stackscript_id  = var.stackscript_id
  stackscript_data = var.stackscript_data
  swap_size       = var.swap_size
  backups_enabled = var.backups_enabled
  watchdog_enabled = var.watchdog_enabled
  booted          = var.booted
  migration_type  = var.migration_type
  firewall_id     = var.firewall_id
  disk_encryption = var.disk_encryption
  backup_id       = var.backup_id
  resize_disk     = var.resize_disk
  placement_group_externally_managed = var.placement_group_externally_managed

  dynamic "metadata" {
    for_each = var.metadata != null ? [var.metadata] : []
    content {
      user_data = base64encode(metadata.value.user_data)
    }
  }

  # create a dynamic block for none or one placement_group, AI!
}
