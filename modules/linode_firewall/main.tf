# ICEBOX: applying a custom least-privilege cloud firewall to harleypig-com is
# deferred — single host, Linode's default firewall suffices. Revisit on
# topology growth (more hosts, a NodeBalancer, services needing tighter
# ingress). The module below is ready to deploy; see README.md.

resource "linode_firewall" "this" {
  label    = var.label
  disabled = var.disabled
  tags     = var.tags

  inbound_policy  = var.inbound_policy
  outbound_policy = var.outbound_policy

  linodes       = var.linodes
  nodebalancers = var.nodebalancers

  dynamic "inbound" {
    for_each = var.inbound
    content {
      label    = inbound.value.label
      action   = inbound.value.action
      protocol = inbound.value.protocol
      ports    = inbound.value.ports
      ipv4     = inbound.value.ipv4
      ipv6     = inbound.value.ipv6
    }
  }

  dynamic "outbound" {
    for_each = var.outbound
    content {
      label    = outbound.value.label
      action   = outbound.value.action
      protocol = outbound.value.protocol
      ports    = outbound.value.ports
      ipv4     = outbound.value.ipv4
      ipv6     = outbound.value.ipv6
    }
  }
}
