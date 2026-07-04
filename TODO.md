# TODO

## Module hygiene (from harleydev ROADMAP Track C, step 1)

**Validations + test coverage — DONE** (audited 2026-07-04). All 12 modules
validate their validatable inputs and have both a success (`command = plan`)
run and per-validation `expect_failures` runs. The old "5 unvalidated modules"
note was stale; the thin modules (`linode_sshkey`, `linode_instance_ip`,
`linode_object_storage_bucket`, `linode_rdns`) are thin because their remaining
inputs are bools/numbers that need no regex, not because of gaps.

**Consistent variable shape — EXAMINED, NOT DOING the blanket reshape**
(2026-07-04). The old item proposed forcing every module onto the
`map(object)` factory shape. Examined against how the modules are actually
built and consumed; the mixed shapes are *correct*, reflecting a real semantic
split rather than drift:

- **Factory modules (3):** `linode_domain`, `linode_domain_record`,
  `linode_rdns` take a `map(object)` and `for_each` the resource internally;
  outputs are maps keyed by the input key. Right for **bulk-collection**
  resources (a zone's records) with no cross-module interdependency and simple
  map outputs — the caller passes the whole set and does *not* `for_each` the
  module.
- **Single-resource modules (9):** `linode_instance`, `linode_volume`,
  `linode_volume_protected`, `linode_firewall`, `linode_instance_config`,
  `linode_instance_disk`, `linode_instance_ip`, `linode_sshkey`,
  `linode_object_storage_bucket` manage **one** resource with scalar/list
  inputs and **scalar outputs** (`instance_id`, `instance_ip_address`, …). The
  caller composes with its own `for_each` (harleydev: `module.servers["web"]`,
  8 of 11 call sites) and cross-references the scalar outputs between calls
  (`instance_configs`/`instance_disks`/`instance_ips` → `module.servers[k]`).

Forcing the 9 single-resource modules into factories would be **wrong, not
just costly**: their `list`/scalar inputs (`tags`, `authorized_keys`,
`inbound`/`outbound` rules, `devices`, `interface`) are *sub-components of one
resource* in the Linode API's own shape — a `map` of tags is nonsensical — and
their scalar outputs would all become maps, forcing every caller reference and
the whole (just-completed, drift-free) harleydev consumption to change for zero
benefit. The one genuine defect was that `CONVENTIONS.md` described the library
as *uniformly* factory; this PR corrects the doc to describe both patterns and
when each applies.

- [x] **Add an `examples/` per module that doubles as a `.tftest.hcl`
  fixture.** Each module now ships `examples/basic/`, plan-tested by an
  `example_basic_plans` run in its `tests/validations.tftest.hcl`.
