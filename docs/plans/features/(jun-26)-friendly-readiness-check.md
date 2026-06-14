<!-- docflow: feature doc. One-screen usability status for DocFlow. -->
# Feature — Friendly Readiness Check

> **Status (2026-06-14):** shipped
> **Owner:** Maintainer
> **Surface:** `scripts/docflow-check.sh`

DocFlow now answers the usability question directly: whether the repo is ready, needs setup, needs adoption, needs repair, or is blocked by validation errors.
The check prints one reason and one next command so users do not need to interpret doctor and validate output manually.

Reference docs:
- Product: [`product-spec/00-overview.md`](../../product-spec/00-overview.md)
- Spec: [`specs/(jun-26)-plugin-workflow.md`](<../../specs/(jun-26)-plugin-workflow.md>)
- Commands: [`references/commands.md`](../../references/commands.md)

Decisions:
- [ADR 0001](../../decisions/0001-plain-markdown-bash.md)

## In flight

| Item | Status |
|------|--------|
| Read-only check script | shipped |
| Claude command and Codex skill wrappers | shipped |
| Scaffold/repair helper installation | shipped |
| README and command reference updates | shipped |

## Feature log

| Date | Change | Ref |
|------|--------|-----|
| 2026-06-14 | Added `docflow-check` to make readiness and next action obvious. | local |

## Next

1. Consider an optional fix mode after the read-only status flow proves clear.
