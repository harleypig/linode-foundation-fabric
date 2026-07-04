resource "linode_user" "this" {
  username   = var.username
  email      = var.email
  restricted = var.restricted

  dynamic "global_grants" {
    for_each = var.global_grants != null ? [var.global_grants] : []
    content {
      account_access        = global_grants.value.account_access
      add_databases         = global_grants.value.add_databases
      add_domains           = global_grants.value.add_domains
      add_firewalls         = global_grants.value.add_firewalls
      add_images            = global_grants.value.add_images
      add_linodes           = global_grants.value.add_linodes
      add_longview          = global_grants.value.add_longview
      add_nodebalancers     = global_grants.value.add_nodebalancers
      add_stackscripts      = global_grants.value.add_stackscripts
      add_volumes           = global_grants.value.add_volumes
      add_vpcs              = global_grants.value.add_vpcs
      cancel_account        = global_grants.value.cancel_account
      longview_subscription = global_grants.value.longview_subscription
    }
  }

  dynamic "domain_grant" {
    for_each = var.domain_grant
    content {
      id          = domain_grant.value.id
      permissions = domain_grant.value.permissions
    }
  }

  dynamic "firewall_grant" {
    for_each = var.firewall_grant
    content {
      id          = firewall_grant.value.id
      permissions = firewall_grant.value.permissions
    }
  }

  dynamic "image_grant" {
    for_each = var.image_grant
    content {
      id          = image_grant.value.id
      permissions = image_grant.value.permissions
    }
  }

  dynamic "linode_grant" {
    for_each = var.linode_grant
    content {
      id          = linode_grant.value.id
      permissions = linode_grant.value.permissions
    }
  }

  dynamic "longview_grant" {
    for_each = var.longview_grant
    content {
      id          = longview_grant.value.id
      permissions = longview_grant.value.permissions
    }
  }

  dynamic "nodebalancer_grant" {
    for_each = var.nodebalancer_grant
    content {
      id          = nodebalancer_grant.value.id
      permissions = nodebalancer_grant.value.permissions
    }
  }

  dynamic "stackscript_grant" {
    for_each = var.stackscript_grant
    content {
      id          = stackscript_grant.value.id
      permissions = stackscript_grant.value.permissions
    }
  }

  dynamic "volume_grant" {
    for_each = var.volume_grant
    content {
      id          = volume_grant.value.id
      permissions = volume_grant.value.permissions
    }
  }

  dynamic "vpc_grant" {
    for_each = var.vpc_grant
    content {
      id          = vpc_grant.value.id
      permissions = vpc_grant.value.permissions
    }
  }
}
