# TODO

## Module hygiene (from harleydev ROADMAP Track C, step 1)

- [ ] Finish input `validation` blocks on the modules that still lack them, so
  every module has success + failure test coverage (mirror the pattern in the
  validated modules such as `linode_volume` / `linode_domain`).
- [ ] Adopt a consistent variable shape across modules (`prefix`, heavy
  `optional()`, maps over lists) per the CFF factory convention.
- [ ] Add an `examples/` per module that doubles as a `.tftest.hcl` fixture.

## harleydev cutover (coordinated, production-sensitive)

- [ ] Repoint harleydev's `account/`, `domains/`, `servers/`, `volumes/`
  configs from `source = "../tfmods/<m>"` to
  `github.com/harleypig/linode-foundation-fabric//modules/<m>?ref=vX.Y.Z`,
  then remove `harleydev/tfmods/`. **Safety gate:** `. bin/set_env` +
  `bin/tf all drift` (or `terraform plan`) must show **no changes** across
  every config before/after — the extracted modules are byte-identical, so a
  clean plan proves the cutover is inert. Runs against the live account, so it
  is a credentialed step.
