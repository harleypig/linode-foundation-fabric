# linode-foundation-fabric Conventions

Repo-specific conventions. The global agent config (`~/.claude/CLAUDE.md` and
`~/.claude/rules/*`) carries everything generic — git/gh workflow, code style,
the QA *dimensions*, Terraform conventions. This file records only what is
specific to **this** repo and overrides the global config where they differ.

linode-foundation-fabric is a **generic, reusable** Terraform module library
(Cloud Foundation Fabric-style) for Linode, built on the published
[`linode/linode`](https://registry.terraform.io/providers/linode/linode/latest)
provider. It holds **no account-specific configuration** — that lives in the
consuming root configuration. One clean, validated, tested module per Linode
resource.

## Relationship to consumers

- A root configuration **consumes** this library by pinned git ref
  (`?ref=vX.Y.Z`): its configs `source` these modules and bump the ref to adopt
  a new release.
- **The provider is HashiCorp/Linode's** (`linode/linode`, on the Registry) —
  there is no first-party provider repo for this library.

## Module layout

One module per Linode resource, `modules/<resource>/`:

```text
modules/linode_<resource>/
  main.tf         # the resource (see the two interface shapes below)
  variables.tf    # inputs + validation blocks (become the test failure cases)
  outputs.tf      # computed results (scalars, or maps keyed by the input key)
  provider.tf     # required_version + required_providers (linode) — self-contained
  README.md       # terraform-docs-generated tables + hand-written prose
  tests/*.tftest.hcl  # plan-only native tests
```

**Two interface shapes — chosen by the resource, not for uniformity.** A
module uses whichever fits how its resource is actually declared and composed;
mixing the two across the library is deliberate, not drift (see the
`TODO.md` examination for the full rationale).

- **Factory** (`linode_domain`, `linode_domain_record`, `linode_rdns`) — the
  module takes a `map(object({...}))` and `for_each`es the resource internally,
  so one module instance manages many; outputs are maps keyed by the input key.
  Right for **bulk-collection** resources (a zone's records) with no
  cross-module interdependency. The caller passes the whole map and does **not**
  `for_each` the module.
- **Single-resource** (everything else — `linode_instance`, `linode_volume`,
  `linode_firewall`, …) — the module manages **one** resource with scalar/list
  inputs (lists being that resource's own sub-blocks: rules, devices, tags) and
  **scalar outputs**. The **caller** composes with its own `for_each`
  (`module.servers["web"].instance_id`) and cross-references the scalar outputs
  between calls. Preferred when the resource has rich interdependencies or is
  composed with sibling resources.

**Each module carries its own `provider.tf`** (a copy of the root `provider.tf`
template: `required_version` + the pinned `linode` provider), so a module stays
self-contained when sourced by ref. `README.md.template` is the scaffold for a
new module.

## Toolchain — real Terraform + the Registry provider

Uses a **locally installed `terraform`** (CI uses `setup-terraform`). The
`linode/linode` provider is **published**, so `terraform init` fetches it from
the Registry — **no dev-override**. Tests are
plan-only with `mock_provider`, so `init` needs no Linode credentials (it only
downloads the provider schema).

- **tflint** (`.tflint.hcl`, bundled terraform ruleset, recommended preset; no
  `--init`/`--deep`) — credential-free.
- **trivy config** (terraform misconfig scanner).
- **terraform-docs** generates each module's README via `bin/build-docs`
  (config: `.terraform-docs.yml`), the single code path for both the
  regenerate hook and the `terraform-docs-check` gate (`bin/build-docs
  --check`), so they cannot drift. A module keeps hand-written prose around the
  generated block.

## Versioning & tagging

The library versions as **one unit** — a single semver `vMAJOR.MINOR.PATCH`
covers all modules. `v0.y.z` is alpha (breakage expected, loose `y.z`); the
`0 → 1` jump declares it stable, after which a breaking module-interface change
requires a major bump. Tags are **annotated**, cut at the merge commit on
`master` (the **release-tag** skill). A consumer pins a module by `?ref=vX.Y.Z`.

## Merge policy

`master` is PR-only. Branch first; never commit on `master`. The local
`no-commit-to-branch` hook plus a server-side ruleset enforce it. Required
checks are the CI jobs below.

## Quality assurance

Mapped to the global `qa.md` dimensions. **Status:** Active · Planned · Off ·
N/A. For the Terraform stack, qa-check composes **terraform-review**.

| # | Dimension | Status | Notes |
|---|-----------|--------|-------|
| 1 | Format | **Active** | `terraform fmt` (gated: pre-commit + CI). |
| 2 | Lint | **Active** | `tflint --recursive` (bundled ruleset, recommended preset) gated in pre-commit + CI. |
| 3 | Type-check | **N/A** | HCL. |
| 4 | Code smell | **Off** | `arch-review` ad hoc. |
| 5 | Security | **Active** | `trivy config` (terraform misconfig) gated. Secrets: `gitleaks` + `detect-private-key` Active. |
| 6 | Tests | **Active** | Plan-only `.tftest.hcl` per module (`mock_provider`, credential-free). See `TESTS.md`. |
| 7 | UI/UX | **N/A** | No UI. |
| 8 | End-to-end | **N/A** | The consuming root configuration owns real-infra testing. |
| 9 | Compatibility | **N/A** | Single provider. |
| 10 | Performance | **N/A** | Config repo. |
| 11 | Reliability | **N/A** | No runtime. |
| 12 | Build | **Active** | `terraform validate` per module (CI, provider from Registry). |
| 13 | Documentation | **Active** | terraform-docs READMEs via `bin/build-docs`, gated by `terraform-docs-check`. |
| 14 | Code review | **Active** (informal) | PR required; solo self-merge. `/code-review` on diffs. |
| 15 | CI | **Active** | GitHub Actions; required checks below. |
