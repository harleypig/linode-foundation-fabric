resource "linode_domain_record" "domain_records" {
  for_each = var.records

  domain_id = each.value.domain_id
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
