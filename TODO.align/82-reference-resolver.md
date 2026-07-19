# 82 — Reference resolver

## Why

CML documents reference atoms/bonds/molecules by id via attributes
like `atomRefs2`, `atomRefs4`, `bondRefs`, `moleculeRefs`, `ref`.
Currently callers must walk the document themselves to resolve
these to actual instances.

## Solution

`Chemicalml::Cml::ReferenceResolver` — walks a document, builds an
id → node index, then exposes lookup methods.

## Work

1. Create `lib/chemicalml/cml/reference_resolver.rb`.
2. API:
   ```ruby
   resolver = Chemicalml::Cml::ReferenceResolver.new(document)
   resolver.find_atom(molecule, "a1")     # → Atom or nil
   resolver.resolve_atom_refs2(bond)      # → [Atom, Atom] or nils
   resolver.unresolved_refs(document)     # → [{ source: Bond, attr: :atom_refs2, missing: ["a99"] }]
   ```
3. Add a constraint `ReferencesShouldResolve` (warning severity)
   that lists unresolved refs in a document.
4. Specs covering resolve + unresolved detection.

## Acceptance

- Resolver resolves a valid atomRefs2 to actual atoms.
- `unresolved_refs` returns missing atom ids.
- All existing specs pass.
