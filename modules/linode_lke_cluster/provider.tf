terraform {
  required_version = ">= 1.7"

  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 3.0"
    }
  }
}
