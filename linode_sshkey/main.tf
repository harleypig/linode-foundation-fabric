resource "linode_sshkey" "this" {
  label   = var.label
  ssh_key = var.ssh_key
}
