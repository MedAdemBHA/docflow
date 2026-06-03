---
name: docs-changelog
description: The changelog discipline of a docflow knowledge base — capture what shipped each month as an immutable record so any AI agent (and any teammate) always has context of past changes. One file per month `(mmm-yy).md`, never delete history, per-feature blocks (outcome / delivered / why it matters / commits). Use when something ships, when writing a release report, or when asked "what changed", "add to changelog", "release notes", "what shipped this month", "record this work".
---

# docs-changelog

The memory of the knowledge base. Every month gets one file; history is **append-only**. This is what the SessionStart hook surfaces so the agent starts each session knowing recent work. Pairs with [`docs-author`](../docs-author/SKILL.md) and [`docs-router`](../docs-router/SKILL.md).

> Golden rule: **never delete or rewrite shipped history.** Reversals get a *new* entry, not an edit.

---

## 1 — One file per month

`changelog/(mmm-yy).md` — lowercase 3-letter month + 2-digit year: `(apr-26).md`, `(may-26).md`.
`changelog/README.md` is the index: a table of `| Month | Highlights |`, newest first.

Link to a month file (parens need angle brackets): `[may-26](<(may-26).md>)`.

---

## 2 — Anatomy of a month file

```markdown
# Month YEAR — <release / period title>

> Comparison window: `<base ref>` (`hash`, date) → `<head ref>` (`hash`, date).
> Scope: `N` commits ahead. Purpose: one line — what this summary is for.

---

## Executive Summary
2–4 paragraphs: the themes, the biggest business-facing change, the biggest
technical change, how to treat the release (patch vs feature vs architectural).

---

## What Changed Since <baseline>

### 1. <Feature / theme name>

**Main outcome:** one sentence.

**Delivered capabilities**
- bullet list of what shipped

**Why it matters**
- business / user impact

**Primary commits**
- `hash` short description

### 2. <next theme>
...
```

Keep entries outcome-first. A reader skimming `**Main outcome:**` lines alone should understand the release.

---

## 3 — The shipping flow (where changelog fits)

The roadmap (`plans/upcoming/`) and the changelog are two ends of one pipe:

```
plans/upcoming/{critical,now,next,later}.md   ── ships ──►   changelog/(mmm-yy).md
        (what's coming)                                        (what landed)
```

When something ships:
1. **Move** the line out of the `plans/upcoming/*` horizon — don't let shipped work linger there (it kills the roadmap's signal).
2. **Add / update** the entry in the current `changelog/(mmm-yy).md`.
3. **Cross-link**: the feature plan's `## What shipped` table references the changelog month; the ADR/spec stay linked from the plan.
4. If a known bug got fixed, move it from `reviews/bugs/open.md` to `reviews/bugs/fixed.md` with the commit ref.

`plans/upcoming/README.md` keeps a short "Recently shipped" pointer list to the last few months — **pointers only, no restating**.

---

## 4 — Generating an entry from git

To build a month/release entry, diff the two refs and group commits by theme:

```bash
# commits in head not yet in base, newest first
git log --no-merges --pretty='%h %ad %s' --date=short BASE..HEAD
# count for the scope line
git rev-list --count --no-merges BASE..HEAD
```

Then: cluster commits into 3–8 themes → write a `### N. Theme` block each → fill outcome / delivered / why / commits → write the Executive Summary last (it summarizes the blocks).

---

## 5 — Why append-only matters

The changelog is the project's long-term memory. An agent (or a new teammate) that reads the newest one or two month files gets the recent trajectory: what was built, why it mattered, which commits. Editing or pruning old months erases that trail. Superseded decisions are recorded as *new* lines that reference the old — the history of the change is itself information.
