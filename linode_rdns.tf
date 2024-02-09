locals {
  rdns = { for r in var.rdns : r["rdns_index"] => r }
}

resource "linode_rdns" "rdns" {
  for_each = local.rdns

  address            = each.value.address
  rdns               = each.value.rdns
  wait_for_available = each.value.wait
}
