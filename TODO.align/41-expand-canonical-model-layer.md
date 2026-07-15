# 41 — Expand canonical Model layer for chemistry completeness

## Why

The canonical `Model::*` layer has 28 classes but the CML wire layer
has 121. Many chemistry concepts (crystallography, spectroscopy,
z-matrix, isotopes, samples, reaction schemes) have no canonical
representation, forcing callers to use wire classes directly —
breaking the "all adapters speak the canonical model" invariant.

## New Model classes

- `Model::Lattice` — `lattice_type`, `a/b/c/alpha/beta/gamma`,
  children: cell_parameters, lattice_vectors
- `Model::Crystal` — wraps lattice + scalar/array geometry
- `Model::ZMatrix` — internal coordinates (atomRefs + lengths/angles)
- `Model::Isotope` — number, spin, abundance, mass
- `Model::IsotopeList` — collection
- `Model::Sample` — sample metadata (state, amount, count)
- `Model::Spectrum` — `id`, `title`, `dict_ref`, xaxis/yaxis,
  spectrum_data
- `Model::Peak` — `atomRefs`, `xValue`, `yValue`, `multiplicity`,
  `peakShape`
- `Model::PeakList` — collection
- `Model::ReactionScheme` — `id`, `name`, reaction_step_list
- `Model::ReactionStep` — `atoms`, `reactiveCentre`, `type`
- `Model::Spectator` / `Model::SpectatorList`
- `Model::MoleculeList` — collection (distinct from `molecule[]`)
- `Model::Observation` — observation record

## Implementation pattern

Each class subclasses `Model::Node` and provides:
- `attr_accessor` for every value
- `initialize` with keyword args + sensible defaults
- `children` returning child Model nodes
- `value_attributes` returning the equality/hash snapshot

## Acceptance

- 14 new Model classes.
- Per-class spec under `spec/chemicalml/model/`.
- Full suite still green.
