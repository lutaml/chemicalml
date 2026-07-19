# 93 — YARD docs for public API

## Why

The public API (`Chemicalml.parse`, `Chemicalml.serialize`,
`Chemicalml::Cli.run`, `Chemicalml::Convention.validate`,
`Chemicalml::Dictionary.load`) lacks YARD docstrings. Without
docs, `yard doc` produces empty output and users have to read source.

## Work

Add concise YARD docstrings to:
- `Chemicalml.parse`, `Chemicalml.serialize`, `Chemicalml.parser_for`
- `Chemicalml::Cli.run` and subcommand methods
- `Chemicalml::Convention.validate`, `validate_report`, `detect_and_validate`
- `Chemicalml::Dictionary.load`
- `Chemicalml::Cml::ReferenceResolver` public methods
- `Chemicalml::Cml::Enums` module

## Acceptance

- `bundle exec yard doc` succeeds with no errors.
- `bundle exec yard server` serves documented API.
