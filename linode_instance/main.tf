resource "linode_instance_disk" "site_disk_swap" {
  filesystem = "swap"
  label      = "512 MB Swap Image"
  linode_id  = linode_instance.site.id
  size       = 512
}

resource "linode_instance_disk" "site_disk" {
  filesystem = "ext4"
  label      = "Arch Linux Disk"
  linode_id  = linode_instance.site.id
  size       = 163328
}

resource "linode_instance_config" "site_config" {
  booted       = false
  comments     = null
  kernel       = "linode/grub2"
  label        = "My Arch Linux Profile"
  linode_id    = linode_instance.site.id
  memory_limit = 0
  root_device  = "/dev/sda"
  run_level    = "default"
  virt_mode    = "paravirt"

  device {
    device_name = "sda"
    disk_id     = 42310020
    volume_id   = 0
  }

  device {
    device_name = "sdb"
    disk_id     = 42310021
    volume_id   = 0
  }

  helpers {
    devtmpfs_automount = true
    distro             = true
    modules_dep        = true
    network            = true
    updatedb_disabled  = true
  }
}

resource "linode_instance" "site" {
  label = "harleypig"
  #image  = "linode/arch"
  region = "us-central"
  type   = "g6-standard-4"
  group  = "harley"
  #migration_type = "cold"
  #resize_disk    = false

  # XXX: This needs to be parameterized (harleydev shouldn't be backed up).
  backups_enabled = true

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

  alerts {
    cpu            = 96
    io             = 4500
    network_in     = 15
    network_out    = 15
    transfer_quota = 80
  }

  # XXX: parameterize
  tags = [
    "prod",
  ]
}
