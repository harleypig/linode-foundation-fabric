resource "linode_domain_record" "domain_records" {
  for_each = var.records

  #domain_id   = module.domains.linode_domain.domains[each.value.domain_index].id
  #domain_id   = linode_domain.domains[each.value.domain_index].id
  domain_id = module.domains.domain_ids[each.value.domain_index]
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
