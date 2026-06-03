# Architecture Decision Records

Decisions that shape the codebase. Capture **why**, not what — code shows what.

## Format

Each ADR is one file: `NNNN-kebab-title.md`. Numbers monotonic, never reused.

```markdown
# NNNN — Title

> **Status:** proposed | accepted | superseded by [NNNN](...) | deprecated
> **Date:** YYYY-MM-DD
> **Deciders:** names/handles

## Context
What forced the decision? Constraints, prior state, pain.

## Decision
What we chose. One sentence first, then detail.

## Consequences
What this buys (good), what this costs (bad), what becomes harder later.

## Alternatives considered
Each alternative + why rejected.
```

## When to write one

- Cross-cutting choice (affects multiple modules)
- Non-obvious trade-off (future-you will ask "why didn't we just...")
- Reversal of an earlier decision (**supersede** the old ADR, don't edit it)

Do NOT write ADRs for: library version bumps, one-file refactors, taste choices.

## Index

| # | Title | Status |
|---|-------|--------|
| [0001](0001-<title>.md) | <title> | Accepted |
