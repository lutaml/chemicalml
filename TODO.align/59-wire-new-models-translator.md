# 59 — Wire new Models through translator

## Why

Models added in TODOs 56-58 are inert without translator mappings.
Add `*_to_canonical` / `*_from_canonical` for each.

## Implementation

Most share the geometry-simple shape (id/title/dictRef/convention +
content). Factor a shared helper to avoid copy-paste.

## Acceptance

- Translator spec for each new Model class.
- Round-trip integration test covers a synthetic doc using one new
  Model class end-to-end.
- Full suite green.
