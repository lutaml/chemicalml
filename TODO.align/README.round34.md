# Round 34 — Constraint descriptions, diverse fixtures, perf baseline, BIG perf fix

This round adds constraint-class descriptions, more diverse fixtures,
a performance baseline spec, and crucially **fixes a 680× performance
regression** discovered by the baseline spec.

## Files

- [136 — Constraint descriptions](136-constraint-descriptions.md)
- [137 — More diverse fixtures](137-more-diverse-fixtures.md)
- [138 — Performance baseline spec](138-performance-baseline-spec.md)
- [139 — Final verification round 34](139-final-verification-round34.md)

## Outcomes

- **Constraint `description` class method** added to
  `Convention::Constraint`. Each constraint can now carry a
  human-readable description of the rule it enforces. Two molecular
  constraints (`AtomMustHaveId`, `BondMustHaveOrder`) updated as
  examples. `chemicalml constraints` command now shows descriptions
  when present.

- **Three new diverse fixtures**:
  - `molecular/ethylene_with_cis_trans_stereo.cml` — bondStereo with
    `atomRefs4` (cis/trans case)
  - `reactions/free_radical_halogenation.cml` — multi-reactant
    reaction with substanceList catalyst
  - `spectroscopy/ethanol_nmr.cml` — NMR spectrum with xaxis/yaxis
    arrays, peakList with multiplicity, metadataList

- **Performance baseline spec** — establishes timing baselines for:
  - XML/JSON serialisation of a 1000-atom molecule (< 2s)
  - Molecular validation of a 1000-atom molecule (< 2s)
  - `atom_count` / `find_atom` queries (< 500ms)
  - Fixture parsing (< 20ms)

- **MAJOR performance fix**: the `ReferencesShouldResolve` constraint
  was taking **47.8 seconds** on a 1000-atom document. Root cause:
  `ReferenceResolver#unresolved_for` called `containing_molecule`
  for every bond, which walked the entire document every time
  (O(n²) for n bonds × n molecules × n atoms).

  Fixed by:
  - Adding lazily-built `atom_index` (id → Atom hash, O(1) lookup)
  - Removing the `containing_molecule` indirection in
    `unresolved_for` — the resolver now uses the global atom index
    directly. CML semantics already enforce that bond refs live in
    the parent molecule (that's `BondMustReferenceAtomsInSameMolecule`'s
    job).

  Result: **47.8s → 68ms (680× faster)**.

- **609 examples, 0 failures, 3 pending** (TOML adapter pending).
  Zero forbidden patterns.

## Architectural insight

The performance baseline spec paid for itself immediately by catching
a 47-second regression that I'd introduced in round 22 when adding
the `ReferencesShouldResolve` constraint. Without the baseline,
this would have shipped to users.

The fix follows the **build indices once, query many times** pattern.
The resolver now builds an `atom_index` lazily on first lookup; all
subsequent `find_atom` calls are O(1). This is a Ruby-native
performance pattern that fits the existing architecture cleanly.

Lesson: baseline specs aren't just for regression detection — they
catch bugs that you didn't know you had. Always write the baseline
before optimising.
