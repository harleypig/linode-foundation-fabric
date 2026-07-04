# Basic usage of the linode_sshkey module. This example doubles as a
# plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "sshkey" {
  source = "../.."

  label   = "harleypig-laptop"
  ssh_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAItest harleypig@example"
}
