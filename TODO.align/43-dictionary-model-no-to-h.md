# 43 — Refactor Dictionary::Model away from hand-rolled `to_h`

## Why

`lib/chemicalml/dictionary/model.rb`, `entry.rb`, `enum.rb`, `link.rb`
define `def to_h` — hand-rolled serialization. The project's coding
standard #2 forbids this. The Loader uses `to_h` to round-trip YAML,
but the canonical Model layer uses `value_attributes` for the same
purpose. Align Dictionary with the rest of the codebase.

## Current state

```ruby
class Model
  def to_h
    { namespace: ..., prefix: ..., title: ...,
      description: ..., entries: entries.map(&:to_h) }
  end
end
```

Same pattern in Entry, Enum, Link.

## Target

- Drop `def to_h`.
- `value_attributes` returns the same shape (used by Loader to dump
  YAML, by `==`/`hash` for equality).
- Loader's `dump_to_hash` calls `model.value_attributes`.

If Loader needs a specific YAML shape (string keys vs symbol keys),
add a thin `as_yaml` adapter — but the model itself only exposes
`value_attributes`.

## Acceptance

- No `def to_h` / `to_hash` anywhere in `lib/chemicalml/dictionary/`.
- Loader round-trip still works (specs pass).
- Full suite still green.
