# 71 — Enrich Violation with offending value

## Why

`Violation` carries `path`, `message`, `severity`, `constraint`.
Debugging is harder than necessary because the actual offending value
is not on the violation — only mentioned inside `message`. Callers
that want to render violations in a UI or aggregate them need to
parse the message string to extract the value.

## Work

1. Add an optional `value:` keyword to `Violation#initialize`. The
   field is the literal offending value (e.g. the duplicated atom id
   `"a1"`).
2. Update `Constraint#violation` to forward `value:` to `Violation.new`.
3. Constraint classes pass the offending value where natural
   (e.g. duplicate id constraints pass the duplicate id).
4. Specs assert the value is carried.

## Acceptance

- `Violation.new(path: "x", message: "y", value: "a1").value == "a1"`.
- No existing spec breaks (value defaults to nil).
- At least 3 constraints populate `value` with the offending value.
