resource "linode_rdns" "rdns" {
  for_each = var.rdns

  address = each.value.address
  rdns    = each.value.rdns
}
