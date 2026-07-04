# linode-foundation-fabric — Agent Guide

Auto-loaded entry point for AI agents working in linode-foundation-fabric — a
generic, reusable Terraform module library (CFF-style) for Linode, built on the
published `linode/linode` provider and extracted from harleydev's `tfmods/`.

## The few things to internalize first

- **This is a library, not live infra.** It holds no account-specific config.
  Modules are validated and plan-tested here; real infrastructure is exercised
  by the consuming root config (harleydev), never here.
- **One module per Linode resource** (`modules/linode_<resource>/`), factory
  `for_each` interface; inputs mirror settable attributes, outputs the computed
  ones.
- **The provider is published** (`linode/linode` on the Registry), so
  `terraform init` fetches it — no dev-override. Tests are credential-free
  (`mock_provider`, `command = plan`). See `TESTS.md`.
- **`master` is PR-only.** Branch first; never commit on `master`.
- **harleydev consumes this by pinned git ref.** A cutover that repoints
  harleydev is coordinated and drift-gated (see `CONVENTIONS.md` and `TODO.md`).

## Where the rest lives

Repo conventions and the QA picture are in [CONVENTIONS.md](CONVENTIONS.md);
the test layout in [TESTS.md](TESTS.md). Generic agent behavior — git/gh
workflow, code style, Terraform tooling, the QA dimensions — comes from the
maintainer's global agent config (`~/.claude/`), which this repo defers to
except where `CONVENTIONS.md` overrides it.

@CONVENTIONS.md
@TESTS.md
