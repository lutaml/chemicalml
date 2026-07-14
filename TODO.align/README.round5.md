# TODO.align (round 5)

Close the stereo coverage gap. `atomParity` and `bondStereo` exist as
wire classes (Base, Schema3, Schema24, Role) but had no canonical
Model representation and no Translator rules. Fixtures that use them
couldn't round-trip through canonical.

| # | Workstream | Status | Depends on |
|---|---|---|---|
| 28 | [Model::AtomParity + Model::BondStereo](28-stereo-model.md) | complete | — |
| 29 | [Wire Atom/Bond to carry stereo children](29-stereo-wire-children.md) | complete | 28 |
| 30 | [Translator rules for stereo](30-stereo-translator.md) | complete | 28, 29 |
| 31 | [Final spec + lint pass](31-final-spec-lint.md) | complete | all |

**All workstreams complete.** 167 examples, 0 failures.

Stereo elements now round-trip: wire → canonical → wire (Schema3 or
Schema24) preserves atomParity and bondStereo values, refs, and
dict_ref. Both produce schema-correct classes at every nested level
via WireClassRegistry.
