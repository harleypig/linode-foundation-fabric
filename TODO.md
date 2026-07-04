# TODO

## Provider versioning

- [ ] Add a way to check the pinned provider version against the latest
  upstream release and flag when an update is available.

## Documentation

- [ ] Add a README paragraph framing the modules as a **foundation**: while
  each module can be used as-is, they are meant to be composed and extended
  as a base for your own custom needs. Point to a worked, end-to-end example
  under an `examples/` directory (a top-level composition example, distinct
  from the per-module `examples/basic/` fixtures) that wires several modules
  together into a realistic configuration — e.g. a DNS/domains setup composing
  the domain, domain-record, and rdns modules via `locals`. Write it
  generically: no account-, host-, or repo-specific names or values.
  Apply this to **both** the latest 1.x and the latest 2.x release lines (the
  1.x line and the provider-v4 2.x line), so the framing and example ship in
  each.
