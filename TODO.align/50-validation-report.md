# 50 — ValidationReport with severity filtering

## Why

`Convention.validate` returns a flat array of `Violation`s. Callers
that want only errors or only warnings have to filter manually. Add
a `ValidationReport` value object that wraps the array and exposes
severity-based views.

## API

```ruby
report = Chemicalml::Convention::ValidationReport.new(violations)
report.errors      # [Violation] with severity == :error
report.warnings    # [Violation] with severity == :warning
report.ok?         # errors.empty?
report.has_warnings? # warnings.any?
report.violations  # raw array (backward compat)
```

Also add `Convention.validate_report(doc)` returning a
`ValidationReport` instead of an array. Existing `validate` keeps its
array return shape (backward compatible).

## Acceptance

- New spec covers all 5 helpers.
- Existing validate specs unchanged.
- Full suite green.
