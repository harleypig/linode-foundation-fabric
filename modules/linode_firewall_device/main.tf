resource "linode_firewall_device" "this" {
  firewall_id = var.firewall_id
  entity_id   = var.entity_id
  entity_type = var.entity_type
}
