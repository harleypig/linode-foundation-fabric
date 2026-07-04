# TODO

## Module hygiene (from harleydev ROADMAP Track C, step 1)

**Validations + test coverage — DONE** (audited 2026-07-04). All 12 modules
validate their validatable inputs and have both a success (`command = plan`)
run and per-validation `expect_failures` runs. The old "5 unvalidated modules"
note was stale; the thin modules (`linode_sshkey`, `linode_instance_ip`,
`linode_object_storage_bucket`, `linode_rdns`) are thin because their remaining
inputs are bools/numbers that need no regex, not because of gaps.

The two remaining hygiene items are **deferred until after the harleydev
cutover** because both are entangled with the variable-shape change, which is
breaking:

- [ ] **Adopt a consistent variable shape** (`map(object)` factory with heavy
  `optional()`; maps over lists). Today the shapes are mixed — 3 modules use
  the `map(object)` factory (`linode_domain`, `linode_domain_record`,
  `linode_rdns`), 6 use `list(...)`, 3 use scalars. **This is a breaking
  module-interface change**: it forces harleydev's module calls to change and
  would make its `terraform plan` no longer a clean no-op, so it must NOT
  precede the drift-free cutover. Do it as a coordinated major bump with
  harleydev updated in lockstep.
- [ ] **Add an `examples/` per module that doubles as a `.tftest.hcl`
  fixture.** **Coupled to the reshape above** — the examples-as-fixtures
  pattern should be built on the final unified shape, so building it now
  (against the soon-to-change shapes) is largely rework (9 of 12 modules would
  be redone). Do it alongside the reshape.

## harleydev cutover (coordinated, production-sensitive)

- [ ] Repoint harleydev's `account/`, `domains/`, `servers/`, `volumes/`
  configs from `source = "../tfmods/<m>"` to
  `github.com/harleypig/linode-foundation-fabric//modules/<m>?ref=vX.Y.Z`,
  then remove `harleydev/tfmods/`. **Safety gate:** `. bin/set_env` +
  `bin/tf all drift` (or `terraform plan`) must show **no changes** across
  every config before/after — the extracted modules are byte-identical, so a
  clean plan proves the cutover is inert. Runs against the live account, so it
  is a credentialed step.
