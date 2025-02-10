resource "linode_instance_disk" "this" {
  linode_id        = var.linode_id
  label            = var.label
  size             = var.size
  authorized_keys  = var.authorized_keys
  authorized_users = var.authorized_users
  filesystem       = var.filesystem
  image            = var.image
  root_pass        = var.root_pass
  stackscript_data = var.stackscript_data
  stackscript_id   = var.stackscript_id
}
