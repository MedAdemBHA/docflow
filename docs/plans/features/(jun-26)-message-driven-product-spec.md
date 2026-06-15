<!-- docflow: feature doc. Message-driven product spec command. -->
# Feature — Message-Driven Product Spec

> **Status (2026-06-03):** shipped
> **Owner:** Maintainer
> **Surface:** `commands/product-spec.md`

Claude users can pass a feature brief or code path to `/docflow:product-spec <msg or code path>` and get product WHAT docs without filling templates by hand.
The command separates product behavior from implementation details, writes `TBD` for unclear product facts, and reports needed spec/plan follow-ups.

Reference docs:
- Product: [`product-spec/00-overview.md`](../../product-spec/00-overview.md)
- Spec: [`specs/(jun-26)-plugin-workflow.md`](<../../specs/(jun-26)-plugin-workflow.md>)
- Commands: [`references/commands.md`](../../references/commands.md)

Decisions:
- [ADR 0001](../../decisions/0001-plain-markdown-bash.md)

## In flight

| Item | Status |
|------|--------|
| Claude command for message/code-path product spec drafting | shipped |
| Docs reference for command usage | shipped |

## Feature log

| Date | Change | Ref |
|------|--------|-----|
| 2026-06-03 | Added `/docflow:product-spec <msg or code path>` command and docs. | local |

## Next

1. Consider a script-backed scanner if product overview inference needs deterministic repo analysis.
