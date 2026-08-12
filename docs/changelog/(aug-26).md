<!-- docflow: monthly changelog. Append-only history. Outcome-first. -->
# August 2026 — Adoption-aware validation

> Window: 2026-08-12 → 2026-08-13. Scope: real-repository compatibility, upgrade safety, and measured context efficiency.

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
| **Observed result** | Repository A: 80 blockers → 0 blockers and 10 summarized warnings. Repository B: 210 blockers → 1 genuine broken link and 17 summarized warnings. |
| **Refs** | [Feature plan](<../plans/features/(aug-26)-adoption-aware-validation.md>) · [technical spec](<../specs/(aug-26)-adoption-aware-validation.md>) |

### 2. Measured context-efficiency documentation — 2026-08-13

| | |
|---|---|
| **Outcome** | Users can evaluate the token-saving claim from a reproducible measurement instead of a vague percentage. |
| **Delivered** | Added the loading contract, exact default bounds, two real-repository measurements, reproduction commands, limitations, and interpretation rules to the main README and context-efficiency reference. |
| **Measured** | Repository A: 127,424 documentation words → 847 automatic context words (99.34% initially avoided). Repository B: 129,865 → 810 (99.38%). |
| **Caveat** | Word count is a stable local proxy, not an exact model-token count; task-specific files still add context when opened. |
| **Refs** | [Context efficiency](../references/context-efficiency.md) |

### 3. README star-history graph — 2026-08-13

| | |
|---|---|
| **Outcome** | Visitors can see DocFlow's GitHub star growth from the project README. |
| **Delivered** | Added the official Star History chart with light/dark variants and a link to the interactive date view. |
| **Compatibility** | The chart remains isolated to one README block so its URL can be replaced with Star History's sealed owner embed if GitHub restricts timeline rendering. |
