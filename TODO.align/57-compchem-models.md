# 57 — Compchem Model classes

## Why

Schema 3 declares 10 compchem-specific elements not yet modeled:
`gradient`, `eigen`, `kpoint`, `kpointList`, `band`, `bandList`,
`basisSet`, `atomicBasisFunction`, `particle`, `electron`. All
are common in computational chemistry output.

## Implementation

- `Model::Gradient` — id/title/dictRef/convention/units/content
- `Model::Eigen` — id/title/dictRef/convention/units/type/content
- `Model::Kpoint` / `Model::KpointList`
- `Model::Band` / `Model::BandList`
- `Model::BasisSet` / `Model::AtomicBasisFunction`
- `Model::Particle` / `Model::Electron`

Each follows the Node pattern: attr_accessor, initialize, children,
value_attributes.

## Acceptance

- 10 new Model classes.
- Per-class spec.
- Full suite green.
