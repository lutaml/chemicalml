# 51 — Convention auto-detection

## Why

Currently a caller has to know the convention QName and pass it to
`Convention::Registry.validate(doc, qname: "convention:molecular")`.
The document itself declares its convention via the `convention`
attribute on its root element — the gem should be able to detect and
dispatch automatically.

## API

```ruby
Chemicalml::Convention::Registry.detect_and_validate(doc)
# → [Violation, ...] (or ValidationReport)
```

Internally:
1. Find the root element (Document or Molecule or Module).
2. Read its `convention` attribute.
3. Look up in `Registry`.
4. If found → run `convention.validate(doc)`.
5. If not found → raise ArgumentError naming the convention.

## Acceptance

- Spec: a doc with `convention="convention:molecular"` auto-validates.
- Spec: unknown convention raises ArgumentError.
- Spec: doc without convention raises ArgumentError.
- Full suite green.
