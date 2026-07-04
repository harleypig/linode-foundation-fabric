resource "linode_firewall_settings" "this" {
  default_firewall_ids = var.default_firewall_ids
}
