---
name: docs-init
description: Initialize docflow in the current repository. Scaffold the 7-category docs tree, write docflow.json, add AGENTS.md/GEMINI.md/.cursorrules, and wire the repo for low-token agent navigation. Use when the user says "set up docflow", "initialize docs", "scaffold docs", "add the docs tree", or "make this repo use docflow".
---

# docs-init

Goal: scaffold docflow in repo. Keep existing files. Do not clobber.

## Steps

1. Pick docs root.
   - Reuse existing `docs/`, `documentation/`, or `.docs/` if present.
   - Else use `docs/`.

2. Pick project name.
   - Prefer repo folder name.
   - If root `README.md` has clear project title, use that.

3. Run scaffold from plugin root:

```bash
bash scripts/scaffold.sh --docs-root <DOCS_ROOT> --project "<PROJECT NAME>" --target "<REPO ROOT>"
```

4. Add root README link if missing:
   - `## Documentation`
   - link to `<DOCS_ROOT>/README.md`

5. Report what was created:
   - docs root
   - `docflow.json`
   - `AGENTS.md`
   - `GEMINI.md`
   - `.cursorrules`

## Rules

- Never overwrite existing docs files.
- Keep `AGENTS.md` and `docflow.json` aligned on docs root.
- After scaffold, use `docs-author` for new docs and `docs-changelog` for shipped work.
