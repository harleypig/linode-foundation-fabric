# The linode_vpc_subnet ipv6 argument is a plugin-framework nested attribute
# (a list of objects), not a legacy block — so it is assigned directly rather
# than rendered as a dynamic block. Its per-entry allocated_range is computed
# and surfaces via outputs.

resource "linode_vpc_subnet" "this" {
  vpc_id = var.vpc_id
  label  = var.label
  ipv4   = var.ipv4
  ipv6   = var.ipv6
}
