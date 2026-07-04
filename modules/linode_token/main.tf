resource "linode_token" "this" {
  scopes = var.scopes
  label  = var.label
  expiry = var.expiry
}
