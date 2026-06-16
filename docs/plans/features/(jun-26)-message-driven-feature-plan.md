<!-- docflow: feature doc. Message-driven feature planning command. -->
# Feature — Message-Driven Feature Plan

> **Status (2026-06-03):** shipped
> **Owner:** Maintainer
> **Surface:** `commands/feature-plan.md`

Claude users can pass a short request to `/docflow:feature-plan <msg>` and get a docflow feature plan without starting from a blank file.
The command derives the dated filename, fills status/log/next-step sections, and reports product/spec follow-ups when the request affects behavior or architecture.

Reference docs:
- Product: [`product-spec/00-overview.md`](../../product-spec/00-overview.md)
- Spec: [`specs/(jun-26)-plugin-workflow.md`](<../../specs/(jun-26)-plugin-workflow.md>)
- Commands: [`references/commands.md`](../../references/commands.md)

Decisions:
- [ADR 0001](../../decisions/0001-plain-markdown-bash.md)

## In flight

| Item | Status |
|------|--------|
| Claude command for message-based feature planning | shipped |
| Docs reference for command usage | shipped |

## Feature log

| Date | Change | Ref |
|------|--------|-----|
| 2026-06-03 | Added `/docflow:feature-plan <msg>` command and docs. | local |

## Next

1. Consider a Codex skill shortcut if Codex needs the same one-line trigger.
