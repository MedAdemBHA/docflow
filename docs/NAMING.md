# Naming Rules

> Goal: read the filename, know **what** + **when** without opening it. No surprises.

## Rules

1. **kebab-case** always — `payment-flow-workflow.md`, never `paymentFlowWorkflow.md` or `payment_flow_workflow.md`
2. **Period prefix `(mmm-yy)-`** on dated docs (specs, reviews, changelog entries, period-scoped plans) — open the tree, see when the work happened.
   - ✅ `(apr-26)-payment-flow-workflow.md`
   - ✅ `changelog/(may-26).md`
   - Lowercase English short month: `jan feb mar apr may jun jul aug sep oct nov dec`
   - 2-digit year (`26` not `2026`) — short, sortable
   - When linking in markdown, **wrap in angle brackets** to keep parens safe: `[text](<path/(may-26)-file.md>)`
3. **Topic prefix groups files** so siblings sort together inside the date bucket:
   - `(apr-26)-payment-*` (overview, workflow, qa-guide)
4. **Numbered prefix** for stable ordered series (no date — these are not snapshots):
   - `product-spec/NN-name.md` — reading order
   - `decisions/NNNN-name.md` — ADRs, monotonic, never reused
5. **No redundant suffixes**: never `-feature.md`, `-spec.md`, `-doc.md`. Add a qualifier only when a sibling would otherwise collide.
   - ✅ `payment-overview.md` + `payment-qa-guide.md` (siblings — qualifiers needed)
   - ❌ `payment-feature.md` (no sibling — drop `-feature`)
6. **Read-at-a-glance**: a teammate scanning the folder must guess content without opening. If they can't, rename.

## Where each rule applies

| Folder | Pattern | Example |
|--------|---------|---------|
| `product-spec/` | `NN-topic.md` (stable) | `04-payments.md` |
| `specs/` | `(mmm-yy)-topic.md` | `(apr-26)-payment-flow-workflow.md` |
| `references/` | `topic.md` (stable) | `api-conventions.md` |
| `decisions/` | `NNNN-decision-title.md` (stable) | `0001-event-sourcing.md` |
| `plans/features/` | `(mmm-yy)-feature-name.md` | `(apr-26)-checkout-redesign.md` |
| `plans/hygiene/` | `(mmm-yy)-topic.md` | `(apr-26)-codebase-cleanup.md` |
| `plans/upcoming/` | rolling roadmap folder (no dates) | `critical.md`, `now.md` |
| `reviews/active/` | `(mmm-yy)-topic.md` | `(apr-26)-checkout.md` |
| `reviews/archive/` | `(mmm-yy)-topic.md` | `(apr-26)-checkout-audit.md` |
| `changelog/` | `(mmm-yy).md` | `(may-26).md` |

## When you write a new doc

- Choose folder first (WHAT vs HOW vs WHY vs PLAN vs SNAPSHOT)
- Apply the folder's pattern
- If a sibling exists with the same root, add the qualifier
- If the doc is a snapshot of state at a point in time, add `(mmm-yy)`
- Never include the day unless you'll write multiple snapshots in one month

## When you rename

- Update the file
- Update every cross-link (`grep -rn "old-name\.md" docs/`)
- Update folder README + root README if listed there
- Run the link-check below

## Link integrity check

```bash
# empty output = all local links resolve
bash scripts/check-links.sh docs
```
