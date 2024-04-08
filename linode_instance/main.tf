resource "linode_instance" "site" {
  label = var.label
  #image  = "linode/arch"
  region = var.region
  type   = var.type
  group  = var.group
  #migration_type = "cold"
  #resize_disk    = false

  backups_enabled = var.backups

  # XXX: Can I control this via terraform?
  #  backups = [
  #    {
  #      available = true
  #      enabled   = true
  #      schedule = [
  #        {
  #          day    = "Sunday"
  #          window = "W10"
  #        },
  #      ]
  #    },
  #  ]

  alert {
    cpu            = var.cpu_alert_threshold
    io             = var.io_alert_threshold
    network_in     = var.network_in_alert_threshold
    network_out    = var.network_out_alert_threshold
    transfer_quota = var.transfer_quota_alert_threshold
  }

  tags = var.tags
}

#resource "linode_instance_config" "site_config" {
#  #booted       = false
#  #comments     = null
#  kernel       = "linode/grub2"
#  label        = "My Arch Linux Profile"
#  linode_id    = linode_instance.site.id
#  memory_limit = 0
#  root_device  = "/dev/sda"
#  run_level    = "default"
#  virt_mode    = "paravirt"
#
#  device {
#    device_name = "sda"
#    disk_id     = linode_instance_disk.site_disk.id
#    volume_id   = 0
#  }
#
#  device {
#    device_name = "sdb"
#    disk_id     = linode_instance_disk.site_disk_swap.id
#    volume_id   = 0
#  }
#
#  helpers {
#    devtmpfs_automount = true
#    distro             = true
#    modules_dep        = true
#    network            = true
#    updatedb_disabled  = true
#  }
#}
#
#resource "linode_instance_disk" "site_disk_swap" {
#  filesystem = "swap"
#  label      = "512 MB Swap Image"
#  linode_id  = linode_instance.site.id
#  size       = 512
#}
#
#resource "linode_instance_disk" "site_disk" {
#  filesystem = "ext4"
#  label      = "Arch Linux Disk"
#  linode_id  = linode_instance.site.id
#  size       = 163328
#}
