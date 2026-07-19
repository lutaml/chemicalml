# Round 33 — CLI run(options) signature alignment

This round refactors every CLI command class so the run method
takes a single `options` hash, matching the user-requested
invocation pattern exactly:

    MyCommandClass.new.run(options)

## Files

- [134 — CLI run(options) alignment](134-cli-run-options-alignment.md)
- [135 — Final verification round 33](135-final-verification-round33.md)

## Outcomes

- Every `Chemicalml::Cli::*Command` now implements
  `def run(options)` (single hash argument). The hash carries both
  positional args (keyed by name: `:file`, `:element`) and flags
  (`:json`, etc.).

- `Chemicalml::Cli::Base` (Thor dispatcher) builds the options hash
  for each command and calls `<Name>Command.new.run(hash)`. Example:
  ```ruby
  desc "validate FILE", "..."
  method_option :json, type: :boolean, aliases: "-j"
  def validate(file)
    ValidateCommand.new.run(file: file, json: options[:json])
  end
  ```

- Each command supports both invocation styles:
  - Instance: `MyCommand.new.run(options)` (primary, per user spec)
  - Class: `MyCommand.run(options)` (convenience, delegates to instance)

- Bug fix: validation guards `return warn(...), 2 unless path`
  were returning `[warn_result, 2]` (array) instead of integer 2.
  Rewrote as explicit `warn; return 2` two-line guards.

- CLI spec updated to test both invocation styles. 17 specs covering
  every command via `MyCommandClass.new.run(options)` direct call.

- **593 examples, 0 failures, 3 pending**. Zero forbidden patterns.

## Architectural insight

The single-hash `run(options)` signature is more flexible than the
prior `(args, options)` split:

- Positional args are named (`file:`, `element:`), not positional.
  Easier to extend (add a new arg = add a new hash key, no method
  signature change).
- Same hash carries flags (`json:`, etc.). One argument, one source
  of truth.
- Commands are unit-testable in isolation without Thor:
  ```ruby
  Chemicalml::Cli::ValidateCommand.new.run(file: "x.cml", json: true)
  ```

The Thor dispatcher is now truly just routing — it parses CLI input
and constructs the options hash. Every command class can be reused
from Rake tasks, RSpec tests, or web handlers without going through
Thor at all.
