# June 2026 - Docflow Adoption

> Window: `initial` (`0000000`) -> `main` (`abc1234`). Scope: 3 commits.

## Summary

- Release type: feature
- User impact: maintainers can find docs, decisions, plans, bugs, and shipped work from one index
- Tech impact: agent sessions can load compact context from docs and changelog files
- Risk / follow-up: keep hook behavior documented in `SECURITY.md`

## What Changed

### 1. Documentation scaffold

| | |
|---|---|
| Outcome | Repository now has the docflow taxonomy and root agent guide |
| Delivered | docs index; product overview; ADR; roadmap; bug catalog |
| Business impact | New maintainers and agents need less manual orientation |
| Commits | `abc1234` add docflow scaffold |

### 2. Context memory

| | |
|---|---|
| Outcome | Agent sessions can load the docs map and newest changelog month |
| Delivered | `docflow.json`; `AGENTS.md`; context hook spec |
| Business impact | Project history is less likely to be missed in future work |
| Commits | `def5678` document context hook |
