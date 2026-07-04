resource "linode_lke_cluster" "this" {
  label       = var.label
  region      = var.region
  k8s_version = var.k8s_version
  tier        = var.tier
  stack_type  = var.stack_type
  subnet_id   = var.subnet_id
  vpc_id      = var.vpc_id
  apl_enabled = var.apl_enabled
  tags        = var.tags

  external_pool_tags = var.external_pool_tags

  dynamic "control_plane" {
    for_each = var.control_plane != null ? [var.control_plane] : []
    content {
      audit_logs_enabled = control_plane.value.audit_logs_enabled
      high_availability  = control_plane.value.high_availability

      dynamic "acl" {
        for_each = control_plane.value.acl != null ? [control_plane.value.acl] : []
        content {
          enabled = acl.value.enabled

          dynamic "addresses" {
            for_each = acl.value.addresses != null ? [acl.value.addresses] : []
            content {
              ipv4 = addresses.value.ipv4
              ipv6 = addresses.value.ipv6
            }
          }
        }
      }
    }
  }

  dynamic "pool" {
    for_each = var.pool
    content {
      type            = pool.value.type
      count           = pool.value.count
      disk_encryption = pool.value.disk_encryption
      firewall_id     = pool.value.firewall_id
      k8s_version     = pool.value.k8s_version
      label           = pool.value.label
      labels          = pool.value.labels
      tags            = pool.value.tags
      update_strategy = pool.value.update_strategy

      dynamic "autoscaler" {
        for_each = pool.value.autoscaler != null ? [pool.value.autoscaler] : []
        content {
          min = autoscaler.value.min
          max = autoscaler.value.max
        }
      }

      dynamic "taint" {
        for_each = pool.value.taint != null ? pool.value.taint : []
        content {
          effect = taint.value.effect
          key    = taint.value.key
          value  = taint.value.value
        }
      }
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []
    content {
      create = timeouts.value.create
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}
