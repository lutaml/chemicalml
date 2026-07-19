# Round 27 — User-facing API, CLI improvements

This round adds the user-facing query API on `Cml::Visitable`, a
top-level `Chemicalml.validate` shortcut, and two new CLI commands
(`inspect`, `elements`).

## Files

- [110 — Document query API](110-document-query-api.md)
- [111 — Top-level Chemicalml.validate](111-toplevel-validate.md)
- [112 — CLI inspect command](112-cli-inspect.md)
- [113 — CLI elements command](113-cli-elements.md)
- [114 — Final verification round 27](114-final-verification-round27.md)

## Outcomes

- **`Cml::Visitable` query methods** (inherited by every wire class):
  - `#each_wire_node`, `#each_atom`, `#each_bond`, `#each_molecule` — recursive iterators
  - `#find_atom(id)`, `#find_bond(id)`, `#find_molecule(id)` — id-based lookup
  - `#atom_count`, `#bond_count`, `#molecule_count` — recursive counts
  - All return Enumerators without a block (Enumerable-style)

- **`Chemicalml.validate(doc)`** — top-level shortcut for
  `Convention.detect_and_validate(doc)`. Users no longer need to
  remember the full namespace.

- **`chemicalml inspect <file>`** — new CLI command. Prints a
  tree-style summary of the document with element names, ids, and
  structure. Useful for debugging.

- **`chemicalml elements`** — new CLI command. Lists every Schema3
  wire class with its XML root name. Useful for introspection.

- **CLI refactor**: `run_validate` now uses `report.summary` instead
  of manual rendering. Cleaner code, better output.

- **559 examples, 0 failures, 3 pending** (TOML adapter pending).
  Zero forbidden patterns.

## Architectural insight

The query methods live on `Visitable` (the marker mixin every wire
class includes) rather than on `Document` specifically. This means
ANY wire class can be the root of a query — `molecule.find_atom(id)`,
`reaction.find_molecule(id)`, etc. This was the right call: the
walker is already general (visits any subtree); exposing query
methods only on Document would have required callers to navigate
up to Document first.

The CLI's `print_tree` helper is recursive but bounded (`max_depth: 6`)
to avoid runaway output on pathological documents.
