resource "linode_iam_user" "this" {
  username = var.username

  account_access = var.account_access
  entity_access  = var.entity_access
}
