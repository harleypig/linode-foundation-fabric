resource "linode_account_settings" "this" {
  backups_enabled            = var.backups_enabled
  network_helper             = var.network_helper
  interfaces_for_new_linodes = var.interfaces_for_new_linodes
  maintenance_policy         = var.maintenance_policy
}
