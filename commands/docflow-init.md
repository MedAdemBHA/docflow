---
description: Scaffold the docflow 7-category documentation tree into the current repo
---

You are setting up a **docflow** knowledge base in this repository.

## Steps

1. **Pick the docs root.** Default `docs/`. If the repo already has a docs folder (`docs/`, `documentation/`, `.docs/`), reuse it. If unsure, ask the user once.

2. **Run the scaffold** (idempotent — never clobbers existing files):
   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/scripts/scaffold.sh" --docs-root <DOCS_ROOT> --project "<PROJECT NAME>" --target "$CLAUDE_PROJECT_DIR"
   ```
   This creates the category tree (`product-spec/ specs/ references/ decisions/ plans/{upcoming,features,hygiene}/ reviews/{bugs}/ changelog/`), drops the templates, writes `docflow.json` at the repo root so the SessionStart hook knows where the docs live, and scaffolds `AGENTS.md` plus optional multi-agent stubs (`GEMINI.md`, `.cursorrules`) pointing at the same docs system.

3. **Wire it into the repo README.** Add a `## Documentation` section to the root `README.md` linking to `<DOCS_ROOT>/README.md` (so docs are browsable on GitHub without Claude Code).

4. **Seed the first changelog.** Create `<DOCS_ROOT>/changelog/(mmm-yy).md` for the current month from the template, summarizing recent git history (`git log --no-merges --pretty='%h %ad %s' --date=short -20`). Group commits into themes. Use the `docs-changelog` skill for the format.

5. **Map.** The scaffold auto-generates `<DOCS_ROOT>/INDEX.md` (compact `path — purpose` tree). Re-run `bash "${CLAUDE_PLUGIN_ROOT}/scripts/docflow-map.sh" "$CLAUDE_PROJECT_DIR/<DOCS_ROOT>"` after adding/renaming docs — this is the one file an agent reads to know the whole tree without scanning it.

6. **Report** what was created and point the user at the `docs-author` (writing) and `docs-router` (reading) skills.

## Rules
- Don't overwrite existing docs — the scaffold skips files that exist; respect that.
- Keep the docs root config in `docflow.json` accurate; the auto-context hook depends on it.
- Keep `AGENTS.md` aligned with `docflow.json`; Codex and other agents depend on that root guidance.
- Follow the naming rules in `<DOCS_ROOT>/NAMING.md` for every file you create after.
