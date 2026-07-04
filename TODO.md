# TODO

## Provider versioning

- [ ] Record which `linode/linode` provider major version this library is
  written against, and keep the library's own major version aligned with it —
  the LFF major should track the provider major.
- [ ] Add a way to check the pinned provider version against the latest
  upstream release and flag when an update is available.

## Module coverage

- [x] Add the remaining Linode resource modules not yet covered by the library.
  Added 28 modules against provider 3.14.1 (full resource parity except 5
  deliberately-skipped niche resources: `object_storage_object`, `lock`,
  `consumer_image_share_group_token`, `producer_image_share_group`,
  `producer_image_share_group_member`).
