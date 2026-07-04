resource "linode_domain" "domains" {
  for_each = var.domains

  domain      = each.value.domain
  soa_email   = each.value.soa_email
  tags        = each.value.tags
  description = each.value.description
  group       = each.value.group
  ttl_sec     = each.value.ttl_sec
  retry_sec   = each.value.retry_sec
  expire_sec  = each.value.expire_sec
  refresh_sec = each.value.refresh_sec

  # axfr_ips is not supported
  axfr_ips = []

  # "slave" is not supported for type
  type = "master"

  # Optional status field to control the rendering of the domain
  status = each.value.status
}
