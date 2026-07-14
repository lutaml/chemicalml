# 26 — Remove dead wire_class_macro.rb

**Status:** complete
**Depends on:** —

## Goal

`lib/chemicalml/cml/wire_class_macro.rb` is dead code — a leftover
from the round-2 macro experiment. Nothing references it. Remove.

## Acceptance

- `lib/chemicalml/cml/wire_class_macro.rb` deleted.
- No references to `WireClassMacro` or `define_wire_classes` in lib/
  or spec/.
- All specs pass.
