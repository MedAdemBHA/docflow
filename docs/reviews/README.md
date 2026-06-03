# Codebase Review — Current State

> **Last updated:** 2026-06-03
> **Scope:** Plugin scripts, manifests, docs workflow, and tests.

## Scorecard

| Area | Structure | Modularity | Readability | Key Risk |
|------|-----------|------------|-------------|----------|
| Bash backend | 8/10 | 7/10 | 7/10 | Shell portability depends on tests and ShellCheck |
| Agent UX | 8/10 | 8/10 | 8/10 | Codex install path is still local/source based |
| Docs taxonomy | 8/10 | 8/10 | 8/10 | Template placeholders must not leak into public docs |
| Test coverage | 7/10 | 7/10 | 8/10 | CI ShellCheck must run because local ShellCheck is unavailable |

## Current Risks

| Risk | Status | Mitigation |
|------|--------|------------|
| GitHub push blocked by credentials | Open | Push with account that has access to `MedAdemBHA/docflow` |
| ShellCheck not run locally | Open | CI installs ShellCheck and runs scripts/hooks/tests |
| Codex marketplace command not public | Open | README documents local marketplace/source setup only |

## Bug Catalog

- Open: [bugs/open.md](bugs/open.md)
- Fixed: [bugs/fixed.md](bugs/fixed.md)
