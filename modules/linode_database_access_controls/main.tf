resource "linode_database_access_controls" "this" {
  database_id   = var.database_id
  database_type = var.database_type
  allow_list    = var.allow_list
}
