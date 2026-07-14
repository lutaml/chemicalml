# 22 — DRY role modules

**Status:** rejected
**Depends on:** —

## Goal (rejected)

Replace 36 nearly-identical Role module files with a single
`Elements::ALL.each_key { const_set(class_name, Module.new) }`
block.

## Why rejected

`const_set(class_name, Module.new)` is **eager** — every role module
is created when `cml/role.rb` loads. The user's global rule mandates
**autoload** (lazy file loading), not `const_set`. The two are not
equivalent:

- `autoload :Foo, "path"` — registers a hook; the file loads only
  when `Foo` is first referenced. Enables lazy loading, avoids
  circular dependencies, keeps the load path clean.
- `const_set(:Foo, Module.new)` — creates the constant eagerly at
  file-load time. No lazy loading.

The 36 tiny role files are the price of admission for the lazy-load
guarantee. They stay.

## Acceptance

- Keep the 36 individual role files under `lib/chemicalml/cml/role/`.
- Keep the autoload declarations in `lib/chemicalml/cml/role.rb`.
- Do not use `const_set` for role modules.
