# Basic usage of the linode_stackscript module. This example doubles as a
# plan-only test fixture: tests/validations.tftest.hcl plans it under a mock
# provider to prove the documented usage stays valid.

terraform {
  required_version = ">= 1.7"
}

module "stackscript" {
  source = "../.."

  label       = "example-stackscript"
  description = "Installs and configures example software on first boot."
  images      = ["linode/ubuntu22.04"]
  script      = <<-EOT
    #!/bin/bash
    # <UDF name="hostname" label="Hostname" />
    apt-get update
  EOT
}
