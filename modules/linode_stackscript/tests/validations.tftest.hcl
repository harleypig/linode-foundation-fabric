# Plan-only tests for the linode_stackscript module. command = plan never
# creates real infrastructure; mock_provider satisfies provider config so no
# Linode token is needed. Run: terraform -chdir=modules/linode_stackscript test

mock_provider "linode" {}

variables {
  label       = "example-stackscript"
  description = "Installs and configures example software on first boot."
  images      = ["linode/ubuntu22.04"]
  script      = "#!/bin/bash\napt-get update\n"
}

run "valid_stackscript_plans" {
  command = plan

  assert {
    condition     = linode_stackscript.this.label == "example-stackscript"
    error_message = "planned StackScript label should match the input"
  }
}

run "rejects_short_label" {
  command = plan

  variables {
    label = "ab" # fewer than 3 characters
  }

  expect_failures = [var.label]
}

run "rejects_label_bad_start" {
  command = plan

  variables {
    label = "-bad" # must start with an alphanumeric character
  }

  expect_failures = [var.label]
}

run "rejects_empty_description" {
  command = plan

  variables {
    description = "" # must not be empty
  }

  expect_failures = [var.description]
}

run "rejects_empty_images" {
  command = plan

  variables {
    images = [] # at least one image is required
  }

  expect_failures = [var.images]
}

run "rejects_bad_image_format" {
  command = plan

  variables {
    images = ["ubuntu22.04"] # missing the '<vendor>/' prefix
  }

  expect_failures = [var.images]
}

run "rejects_script_without_shebang" {
  command = plan

  variables {
    script = "apt-get update\n" # must begin with a shebang line
  }

  expect_failures = [var.script]
}

run "example_basic_plans" {
  command = plan

  module {
    source = "./examples/basic"
  }
}
