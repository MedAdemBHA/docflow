<!-- docflow: product-spec entry point. WHAT the product is. Stable, numbered (00 first). -->
# Example App - Product Specification Overview

## What It Is

Example App is a small repository that uses docflow to keep documentation and changelog memory visible to AI coding agents.

## User Value

| User | Need | Docflow surface |
|------|------|-----------------|
| Maintainer | Understand current project state fast | `docs/README.md` and `docs/INDEX.md` |
| AI agent | Start with recent context | newest file in `docs/changelog/` |
| Reviewer | See why a choice was made | `docs/decisions/` |

## Core modules

| # | Module | What it does |
|---|---|---|
| 1 | Documentation hub | Gives humans a browsable source of truth |
| 2 | Agent route map | Points agents to the smallest relevant document |
| 3 | Session context | Loads bounded recent project memory |
| 4 | Validation | Detects broken links, stale maps, and missing structure |

## Related

- Technical spec: [context hook](<../specs/(jun-26)-context-hook.md>)
- Decision: [0001 session context hook](../decisions/0001-session-context-hook.md)

## Update Log

| Date | Change | Ref |
|---|---|---|
| 2026-06-03 | Created the example product overview. | `docflow-init` |
| 2026-08-13 | Expanded the example into a validated public demo. | `demo-refresh` |
