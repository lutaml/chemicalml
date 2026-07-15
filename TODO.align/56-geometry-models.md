# 56 — Geometry Model classes

## Why

CML declares 6 geometry primitives (`point3`, `vector3`, `line3`,
`plane3`, `sphere3`, `transform3`) plus `cellParameter` and
`dimension` — all share the same shape (id/title/dictRef/convention +
content). They're used as children of `atom`, `molecule`, `crystal`,
etc. Without canonical Models, callers must use wire classes directly.

## Implementation

One Model class per element. Each carries `id`, `title`, `dict_ref`,
`convention`, `content` (the geometry string). Identical shape, so
specs can be parametrized.

For `cellParameter`: also `cellType` attribute (per Schema 3 XSD).
For `dimension`: also `name` attribute.

## Acceptance

- 8 new Model classes registered.
- Per-class spec.
- Full suite green.
