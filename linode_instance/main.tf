resource "linode_instance" "site" {
  label           = var.label
  image           = var.image
  region          = var.region
  type            = var.type
  migration_type  = var.migration_type
  resize_disk     = var.resize_disk
  backups_enabled = var.backups
  tags            = var.tags
  swap_size       = var.swap_size
}