locals {
  records = { for r in var.records : r["record_index"] => r }
}

resource "linode_domain_record" "domain_records" {
  for_each = local.records

  domain_id   = linode_domain.domains[each.value.domain_index].id
  record_type = each.value.record_type
  target      = each.value.target
  name        = each.value.name
  ttl_sec     = each.value.ttl_sec
  priority    = each.value.priority
  protocol    = each.value.protocol
  service     = each.value.service
  tag         = each.value.tag
  port        = each.value.port
  weight      = each.value.weight
}
