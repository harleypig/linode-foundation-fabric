terraform {
  required_version = ">= 1.7"

  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 4.0"
    }
  }
}
