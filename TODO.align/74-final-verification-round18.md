# 74 — Final verification round 18

## Work

1. Full rspec suite — must be green.
2. rubocop on touched files — must be clean.
3. Forbidden-pattern scan: 0 hits for require_relative, def to_h/from_h/to_xml/from_xml on model classes, double( in specs, send(/instance_variable_*, respond_to? in lib/.
4. Update CLAUDE.md with: Detection covers 8 conventions; JSON/YAML round-trip proven; iterative walker; enriched Violation; documented Schema24 limitation.
5. Write `TODO.align/README.round18.md` summarising this round.

## Acceptance

- All four scans clean.
- CLAUDE.md current.
- README.round18.md exists.
