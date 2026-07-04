# linode-foundation-fabric Test Layout

The global `testing.md` carries the bar (success + failure paths, a regression
test per bug); this file records what exists here and how to run it.

## One tier: credential-free, plan-only

Every module has `tests/*.tftest.hcl` using Terraform's native `terraform test`
framework, **plan-only** (`command = plan`) with `mock_provider "linode" {}`.
This needs **no Linode credentials** and creates **no real infrastructure** —
it is what gates `master`. Real-infrastructure testing is the consuming root
configuration's job, not this library's.

`terraform init` fetches the `linode/linode` provider schema from the Registry
(no token — a plain provider download). `mock_provider` then supplies behavior,
and `command = plan` never creates resources.

## What is tested

Per module: a valid `command = plan` run (asserting the resource plans and key
inputs pass through), plus an `expect_failures` run for **each** input
`validation` block — so every validator has a failing-input regression case.

## Running

```sh
# One module (init fetches the provider from the Registry; no token):
terraform -chdir=modules/linode_volume init
terraform -chdir=modules/linode_volume test

# All modules:
for m in modules/*/; do
  terraform -chdir="$m" init -input=false
  terraform -chdir="$m" test || exit 1
done
```

## Safety

- **`command = plan` only.** No real resources, no cost, no credentials.
- This library never targets live infrastructure; the consuming root
  configuration guards that.

## Coverage policy

Cover the valid path **and** a failing case per validation; add a regression
test with each bug fix (`testing.md`). Modules still missing validations are
tracked in `TODO.md`.
