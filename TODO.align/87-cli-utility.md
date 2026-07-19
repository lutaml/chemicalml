# 87 — CLI utility for validation

## Why

A user-facing CLI makes the gem immediately useful for command-line
validation of CML files. Without a CLI, users have to write Ruby
to use the gem.

## Work

Create `exe/chemicalml` (executable) with subcommands:

- `chemicalml validate <file>` — auto-detect convention, print
  violations to stderr, exit non-zero if errors.
- `chemicalml conventions` — list registered conventions.
- `chemicalml dictionaries` — list builtin dictionaries.

Wire it through `Chemicalml::Cli` module under
`lib/chemicalml/cli.rb` so the logic is reusable.

## Acceptance

- `bundle exec chemicalml validate spec/fixtures/schema3/molecular/water.cml`
  parses, detects convention:molecular, prints nothing, exits 0.
- `chemicalml conventions` lists all 8 conventions.
- `chemicalml dictionaries` lists all built-in dictionaries.
