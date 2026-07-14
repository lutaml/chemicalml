# TODO.align (round 9)

Data-loss fixes + alias consolidation.

| # | Workstream | Status |
|---|---|---|
| 37 | Add formula/property/label to wire + canonical Molecule | complete |
| 38 | Consolidate 36 alias files into one | complete |
| 39 | Final spec + lint pass | complete |

## Issues fixed

### Data loss: Molecule silently dropped formula, property, label children

The molecular convention allows `<molecule>` to contain `<formula>`,
`<property>`, and `<label>` children. The wire class (`Base::Molecule`)
didn't declare these attributes, so they were silently dropped during
parsing. The `water_with_properties.cml` fixture has 2 `<property>`
elements inside `<molecule>` — both were lost.

Fixed by:
- Adding `formulas`, `properties`, `labels` attributes to `Base::Molecule`
  with corresponding `map_element` declarations.
- Adding the same fields to `Model::Molecule` (canonical).
- Adding translator rules in both directions (`molecule_to_canonical` /
  `molecule_from_canonical`).

Verified: `water_with_properties.cml` now parses with
`properties.length == 2` and `dict_ref == "cmlDict:molmass"`.

### DRY: 36 alias files consolidated into one

Each `lib/chemicalml/cml/{atom,bond,...}.rb` was a 10-line file doing
`const_set(:Foo, Schema3::Foo)`. 36 files of identical boilerplate.

Consolidated into `lib/chemicalml/cml/aliases.rb` — a single file that
loops `Elements::ALL` and aliases each. All 36 autoloads in `cml.rb`
point at this file, which loads lazily when the first alias is
referenced.

Note: `const_set` here ALIASES existing `Schema3::Foo` classes — it
does NOT create new classes. This is distinct from the rejected
round-2 pattern where `const_set` was used to eagerly GENERATE new
wire classes.

## Final metrics

- 179 examples, 0 failures
- 0 forbidden patterns
- 227 lib files (down from 263 — 36 alias files eliminated)
