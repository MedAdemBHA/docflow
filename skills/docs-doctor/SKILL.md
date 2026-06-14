---
name: docs-doctor
description: Read-only docflow diagnosis for any repo. Scans existing docs, config, agent guidance, changelog, helper scripts, validation health, placeholders, and broken links; recommends init, adopt, or repair. Use when the user asks "check docs setup", "should I init docflow", "why is docflow not working", "doctor", or "audit documentation setup".
---

# docs-doctor

Goal: inspect before changing anything. This skill is read-only.

## Run

```bash
bash scripts/docflow-doctor.sh --target <REPO ROOT>
```

If running from an installed plugin where scripts are not in the target repo, use the plugin script path.

## Interpret

- `docflow-init` = no meaningful docs found; scaffold is safe.
- `docflow-adopt` = docs/README already exist; preserve them and add missing docflow infrastructure.
- `docflow-repair` = docflow exists; regenerate map/check links/report placeholders.
- `validation: fail` = docs have blockers; run `docs-validate` for details.

## Rules

- Do not edit files.
- Do not run scaffold/adopt/repair.
- Keep output concise and copy the doctor's section headings.
