resource "linode_domain" "domains" {
  for_each = var.domains

  domain      = each.value.domain
  soa_email   = each.value.soa_email
  tags        = each.value.tags
  description = each.value.description
  group       = each.value.group
  ttl_sec     = try(each.value.ttl_sec, 0)
  retry_sec   = try(each.value.retry_sec, 0)
  expire_sec  = try(each.value.expire_sec, 0)
  refresh_sec = try(each.value.refresh_sec, 0)

  # axfr_ips is not supported
  axfr_ips = []

  # "slave" is not supported for type
  type = "master"

  # Optional status field to control the rendering of the domain
  status = each.value.status
}
