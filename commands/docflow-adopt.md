---
description: Safely adopt existing repository docs into docflow without overwriting files
---

You are adopting an existing repository into docflow.

## Steps

1. Run doctor first:
   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/scripts/docflow-doctor.sh" --target "$CLAUDE_PROJECT_DIR"
   ```

2. Pick docs root:
   - Use the doctor-detected root if present.
   - Else use `docs`.

3. Pick project name:
   - Prefer root README title.
   - Else use the repo folder name.

4. Run adopt:
   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/scripts/docflow-adopt.sh" --target "$CLAUDE_PROJECT_DIR" --docs-root <DOCS_ROOT> --project "<PROJECT NAME>"
   ```

5. Report what was created and what was skipped.

## Rules

- Never move, delete, or rewrite existing docs.
- Existing `README.md`, `AGENTS.md`, `GEMINI.md`, `.cursorrules`, and docs files must be preserved.
- Adoption may add missing docflow files, helper scripts, `docflow.json`, `INDEX.md`, and one adoption review doc.
