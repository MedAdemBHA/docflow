<!-- docflow: monthly changelog. Append-only history. Outcome-first. -->
# August 2026 — Adoption-aware validation

> Window: local working tree, 2026-08-12. Scope: real-repository compatibility and upgrade safety.

## Summary

- **Release type:** feature and hardening
- **User impact:** Established documentation systems can use DocFlow validation without renaming or reshaping every existing document.
- **Tech impact:** Validation profiles, code-aware placeholder scanning, helper upgrades, bounded changelog context, and adoption regression fixtures.
- **Risk / follow-up:** Validate against more repository shapes before making strict validation the default for legacy configurations.

## What Changed

### 1. Adoption-aware validation — 2026-08-12

| | |
|---|---|
| **Outcome** | Native DocFlow repositories retain strong conventions while adopted repositories block objective breakage and treat structural differences as cleanup guidance. |
| **Delivered** | Strict/adopted profiles; compatibility-safe defaults for legacy configs; code-aware placeholder and link scans; summarized adoption warnings; managed-helper upgrades; readiness detection for outdated helpers; bounded summary/latest-entry context; real-world regression fixtures. |
| **Verification** | DocFlow strict validation: 0 errors/0 warnings; ShellCheck clean; scaffold smoke test and all seven regression scripts pass; Codex plugin manifest and three changed skills validate. |
| **Observed result** | `BO-`: 80 blockers → 0 blockers and 10 summarized warnings. `BO`: 210 blockers → 1 genuine broken link and 17 summarized warnings. |
| **Refs** | [Feature plan](<../plans/features/(aug-26)-adoption-aware-validation.md>) · [technical spec](<../specs/(aug-26)-adoption-aware-validation.md>) |
