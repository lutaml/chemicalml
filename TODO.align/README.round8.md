# TODO.align (round 8)

Edge-case correctness fixes.

| # | Workstream | Status |
|---|---|---|
| 36 | Edge-case correctness | complete |

**Issues fixed**:

1. **`Chemicalml.parse(nil)` crashed** — `root_element_of(nil)` called
   `nil.match(...)`, raising `NoMethodError`. Added nil and empty
   checks in `Chemicalml.parse` that raise `ArgumentError` with a
   clear message.

2. **`KNOWN_ROOTS` mapped `<molecule>` to Document** — but
   `Document` expects `<cml>` root. A bare `<molecule>` parsed as
   an empty Document with 0 molecules. Fixed by mapping each root
   to its own wire class: `<molecule>` → Molecule, `<reaction>` →
   Reaction, `<reactionList>` → ReactionList. Now
   `Chemicalml.parse("<molecule id='m1'/>")` returns a
   `Schema3::Molecule` with `id="m1"`.

**Final metrics**: 179 examples, 0 failures. All edge cases handled.
