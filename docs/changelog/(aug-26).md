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
| **Measured** | Repository A: 127,424 documentation words → 605 automatic context words (99.53% initially avoided). Repository B: 129,865 → 481 (99.63%). |
| **Caveat** | Word count is a stable local proxy, not an exact model-token count; task-specific files still add context when opened. |
| **Refs** | [Context efficiency](../references/context-efficiency.md) |

### 3. README star-history graph — 2026-08-13

| | |
|---|---|
| **Outcome** | Visitors can see DocFlow's GitHub star growth from the project README. |
| **Delivered** | Added the official Star History chart with light/dark variants and a link to the interactive date view. |
| **Compatibility** | The chart remains isolated to one README block so its URL can be replaced with Star History's sealed owner embed if GitHub restricts timeline rendering. |

### 4. Guided public demo — 2026-08-13

| | |
|---|---|
| **Outcome** | Repository visitors can understand DocFlow's setup decision, routing model, session payload, and documentation lifecycle without reading the implementation first. |
| **Delivered** | Replaced the minimal demo with a four-step walkthrough, realistic terminal output, direct question-to-document links, and local commands; expanded `examples/basic-repo/` into a validated guided tour with managed helper scripts. |
| **Accuracy** | Corrected the documented hook defaults to 30 index lines and 20 changelog lines, then refreshed both anonymous repository measurements. |
| **Verification** | Example readiness, repository tests, link checking, ShellCheck, strict validation, and Codex plugin validation. |

### 5. Clean setup and value guide — 2026-08-13

| | |
|---|---|
| **Outcome** | New visitors can understand DocFlow's value, repository impact, and usable installation paths before reading internal details. |
| **Delivered** | Reorganized the README into a with/without comparison, exact files added, explicit non-goals, working Claude setup, verified portable setup, honest Codex publication status, compact command reference, and runnable demo. |
| **Removed** | Duplicate per-agent setup instructions, an unverified Codex CLI command, repeated command tables, and the internal GitHub packaging checklist. |
| **Source** | Codex plugin availability and new-session behavior were checked against the official OpenAI plugin documentation. |
