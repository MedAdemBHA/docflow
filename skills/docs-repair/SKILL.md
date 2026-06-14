---
name: docs-repair
description: Safe maintenance for an existing docflow setup. Regenerates INDEX.md, installs missing helper scripts, runs link checks, and reports placeholder/validation issues. Use when docflow exists, after adding or renaming docs, or when docs-doctor recommends docflow-repair.
---

# docs-repair

Goal: safe generated-file maintenance only.

## Run

```bash
bash scripts/docflow-repair.sh --target <REPO ROOT>
```

## It May Change

- `<DOCS_ROOT>/INDEX.md`
- missing helper scripts under `scripts/`

## It Must Not Change

- README content
- product specs
- ADRs
- changelog months
- roadmap/plans
- existing project docs

Report broken links, placeholders, and validation warnings instead of fixing content unless the user asks.
