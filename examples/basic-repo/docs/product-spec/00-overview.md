# Example App - Product Specification Overview

## What It Is

Example App is a small repository that uses docflow to keep documentation and changelog memory visible to AI coding agents.

## User Value

| User | Need | Docflow surface |
|------|------|-----------------|
| Maintainer | Understand current project state fast | `docs/README.md` and `docs/INDEX.md` |
| AI agent | Start with recent context | newest file in `docs/changelog/` |
| Reviewer | See why a choice was made | `docs/decisions/` |

## Related

- Technical spec: [context hook](<../specs/(jun-26)-context-hook.md>)
- Decision: [0001 session context hook](../decisions/0001-session-context-hook.md)
