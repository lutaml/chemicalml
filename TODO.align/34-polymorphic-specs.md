# 34 — Polymorphic API specs

**Status:** complete
**Depends on:** 32, 33

## Goal

Specs covering:
- Compchem fixture parses to a non-empty Schema3 Module.
- Polymorphic Translator dispatches Document and Module correctly.
- Unknown roots / inputs raise ArgumentError.
- Round-trip compchem → canonical → compchem preserves structure.

## Acceptance

All specs green.
