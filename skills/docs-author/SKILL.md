---
name: docs-author
description: WRITE side of a docflow knowledge base — the taxonomy + naming + cross-linking discipline for authoring docs in any repo. Pick the right category (product-spec / specs / decisions / references / plans / reviews), apply the folder's naming pattern, fill the matching template, and cross-link. Use when adding or restructuring docs, writing an ADR, a spec, a feature plan, or a review. Triggers — "write a doc for X", "where should this doc go", "add an ADR", "document this decision", "naming convention for docs", "new spec", "new feature plan", "set up docs structure".
---

# docs-author

Author docs the docflow way: **choose category → apply naming → fill template → cross-link.** Companion of [`docs-router`](../docs-router/SKILL.md) (read side) and [`docs-changelog`](../docs-changelog/SKILL.md) (history). Templates live in the plugin's `templates/` dir; `docs-init` or `/docflow-init` drops them into a repo.

> A doc's filename should tell a teammate **what** + **when** without opening it. If it can't, rename.

## Writing style (enforce on every doc)
Direct, tech + business. No filler.
- Tables and bullets over paragraphs. One claim per line.
- Lead with the outcome/decision; cut "this document describes…", "in order to", "it is important to note".
- Concrete: names, paths, numbers, commit hashes. No adjectives that carry no info.
- Each section earns its place — if a placeholder stays empty, delete the section.
- Max one short intro line per doc; the structure does the rest.

---

## 1 — Pick the category (what is this doc?)

| The doc answers… | Category | Folder |
|------------------|----------|--------|
| WHAT a feature does (user-facing) | product spec | `product-spec/` |
| HOW it's built (data flow, API contract, lifecycle) | technical spec | `specs/` |
| WHY we chose an approach | decision (ADR) | `decisions/` |
| HOW to do X / a convention / cheat sheet | reference | `references/` |
| WHAT's planned / status / roadmap | plan | `plans/` (`features/`, `hygiene/`, `upcoming/`) |
| Current quality / known bugs / audit | review | `reviews/` (`active/`, `archive/`, `bugs/`) |
| WHAT shipped, by month | changelog | `changelog/` — see [`docs-changelog`](../docs-changelog/SKILL.md) |

One doc, one category. If it spans two, it's two docs that **cross-link**.

---

## 2 — Apply the naming pattern

| Folder | Pattern | Example |
|--------|---------|---------|
| `product-spec/` | `NN-topic.md` (stable, reading order) | `04-jobs.md` |
| `specs/` | `(mmm-yy)-topic.md` (dated snapshot) | `(apr-26)-tab-system-workflow.md` |
| `references/` | `topic.md` (stable) | `newtable-component.md` |
| `decisions/` | `NNNN-title.md` (monotonic, never reused) | `0001-url-as-state.md` |
| `plans/features/` | `(mmm-yy)-feature-name.md` | `(apr-26)-create-job-stepper.md` |
| `plans/hygiene/` | `(mmm-yy)-topic.md` | `(apr-26)-codebase-cleanup.md` |
| `plans/upcoming/` | rolling roadmap, no dates | `critical.md`, `now.md`, `next.md`, `later.md` |
| `reviews/active/`,`archive/` | `(mmm-yy)-topic.md` | `(may-26)-tab-system.md` |
| `changelog/` | `(mmm-yy).md` | `(may-26).md` |

Rules:
- **kebab-case** always — never `camelCase` or `snake_case`.
- **`(mmm-yy)-` prefix** on dated docs: lowercase 3-letter month + 2-digit year — `jan feb mar apr may jun jul aug sep oct nov dec`.
- **Stable numbers** (`NN-`, `NNNN-`) for ordered series that are *not* snapshots — product-spec reading order, ADRs.
- **No redundant suffixes** — never `-feature.md`, `-spec.md`, `-doc.md`. Add a qualifier only when a sibling would otherwise collide (`tab-system-overview` + `tab-system-qa-guide`).
- **Topic prefix groups siblings** so they sort together (`(apr-26)-tab-system-*`).

---

## 3 — Fill the template

Each category has a skeleton in the plugin's `templates/`. Key shapes:

**ADR** (`decisions/NNNN-title.md`):
```markdown
# NNNN — Title

> **Status:** proposed | accepted | superseded by [NNNN](...) | deprecated
> **Date:** YYYY-MM-DD
> **Deciders:** names/handles

## Context        — what forced the decision? constraints, prior pain
## Decision       — what we chose (one sentence, then detail)
## Consequences   — good / bad / what gets harder
## Alternatives considered  — each + why rejected
```
Write an ADR for: cross-cutting choices, non-obvious trade-offs, reversals (supersede the old one — never edit it). NOT for: version bumps, one-file refactors, taste.

**Spec** (`specs/(mmm-yy)-topic.md`): header block (`Module:` / `Route:` / `Branch:`), then numbered sections — architecture, data model, API surface, state, edge cases. Plus a `Related:` block linking plan + review + ADRs.

**Feature plan** (`plans/features/(mmm-yy)-name.md`): `Status` / `Owner` / `Surface` header, then `## What shipped` (table w/ commit refs) · `## In flight` · `## Queued`.

**Review** (`reviews/...`): `Last updated` / `Scope` header, scorecard table, P0/P1/P2 findings.

---

## 4 — Cross-link (no orphan docs)

Bidirectional. The chain that ties a feature together:

```
product-spec/NN-feature.md   (WHAT)
   ↕
specs/(mmm-yy)-feature.md     (HOW)  ──► decisions/NNNN-*.md  (WHY)
   ↕
plans/features/(mmm-yy)-feature.md  (STATUS)
   ↕
reviews/active/(mmm-yy)-feature.md  (QUALITY)
```

- Every spec ends with a `Related:` list (plan, review, ADRs).
- Every ADR links the specs/product-specs it affects.
- The docs-root `README.md` indexes everything — **add your new doc to it.**
- **Filenames with parentheses must be wrapped in angle brackets in links**, or the renderer breaks:
  `[text](<specs/(may-26)-file.md>)` — not `[text](specs/(may-26)-file.md)`.

---

## 5 — After writing

1. **Regenerate the map**: `bash scripts/docflow-map.sh <DOCS_ROOT>` → updates `<DOCS_ROOT>/INDEX.md` (the compact `path — purpose` tree every agent reads first). New doc needs a clear H1 — that becomes its one-liner.
1. Add the doc to the docs-root `README.md` index + the folder's own README if it has one.
2. If a decision shipped or a plan item completed, reflect it in `changelog/` (see [`docs-changelog`](../docs-changelog/SKILL.md)).
3. On rename: update the file, `grep -rn "old-name\.md"` every cross-link, fix README entries, re-run the link check.

```bash
# link integrity — empty output = all links resolve (swap <DOCS> for your docs root)
while read line; do
  f=$(echo "$line" | cut -d: -f1); d=$(dirname "$f")
  echo "$line" | grep -oE '\]\([^)]+\)' | while read link; do
    target=$(echo "$link" | sed 's/^](//;s/)$//;s/^<//;s/>$//' | cut -d'#' -f1)
    [[ "$target" =~ ^https?:// || -z "$target" ]] && continue
    [[ -f "$d/$target" ]] || echo "BROKEN: $f -> $target"
  done
done < <(grep -rn "\.md)" <DOCS> --include="*.md" 2>/dev/null)
```
