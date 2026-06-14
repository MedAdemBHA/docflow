<!-- docflow: feature doc. Validation and update-log readiness. -->
# Feature — Document Validation And Update Logs

> **Status (2026-06-14):** shipped
> **Owner:** Maintainer
> **Surface:** `scripts/docflow-validate.sh`

DocFlow now has a deterministic readiness gate for documentation work.
Agents can validate links, map freshness, metadata, update logs, placeholder leakage, changelog names, and required sections before reporting docs complete.

Reference docs:
- Product: [`product-spec/00-overview.md`](../../product-spec/00-overview.md)
- Spec: [`specs/(jun-26)-document-validation.md`](<../../specs/(jun-26)-document-validation.md>)
- Commands: [`references/commands.md`](../../references/commands.md)

Decisions:
- [ADR 0001](../../decisions/0001-plain-markdown-bash.md)

## In flight

| Item | Status |
|------|--------|
| Script-backed validation gate | shipped |
| Claude command and Codex skill wrappers | shipped |
| Template update-log sections | shipped |
| Doctor validation summary | shipped |

## Feature log

| Date | Change | Ref |
|------|--------|-----|
| 2026-06-14 | Added validation gate from user feedback about missing logs, metadata, and blockers. | local |

## Next

1. Consider optional git hook or CI wiring after the command-level gate proves stable.
