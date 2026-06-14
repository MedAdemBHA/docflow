---
description: Validate docflow docs before reporting documentation work complete
---

Run the deterministic docflow validation gate for this repo.

## Steps

1. Find the docs root:
   - Read `docflow.json` from `$CLAUDE_PROJECT_DIR` if present and use `docsRoot`.
   - Otherwise use `docs`.
2. Run validation:
   ```bash
   bash "$CLAUDE_PROJECT_DIR/scripts/docflow-validate.sh" --target "$CLAUDE_PROJECT_DIR"
   ```
   If the target repo does not have `scripts/docflow-validate.sh`, use:
   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/scripts/docflow-validate.sh" --target "$CLAUDE_PROJECT_DIR"
   ```
3. Treat a non-zero exit as a blocker. Fix errors before saying docs are complete.
4. Treat warnings as follow-up cleanup unless the user asked for a strict documentation cleanup pass.

## Report

Return:

- validation status: pass or failed
- blocking errors, if any
- warning count and the most important warnings
