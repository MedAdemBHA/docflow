---
name: docs-init
description: Initialize docflow in the current repository. Scaffold the 7-category docs tree, write docflow.json, add AGENTS.md/GEMINI.md/.cursorrules, and wire the repo for low-token agent navigation. Use when the user says "set up docflow", "initialize docs", "scaffold docs", "add the docs tree", or "make this repo use docflow".
---

# docs-init

Goal: initialize docflow only when doctor says this repo has no meaningful docs yet. Keep existing user-authored files; generated maintenance files may be refreshed.

## Steps

1. Run doctor first.

```bash
bash scripts/docflow-doctor.sh --target <REPO ROOT>
```

2. Route by recommendation.
   - `docflow-init`: continue.
   - `docflow-adopt`: stop and use `docs-adopt` instead.
   - `docflow-repair`: stop and use `docs-repair` instead.

3. Pick docs root.
   - Use `docs/` unless the user explicitly chooses another root.

4. Pick project name.
   - Prefer repo folder name.
   - If root `README.md` has clear project title, use that.

5. Run scaffold from plugin root:

```bash
bash scripts/scaffold.sh --docs-root <DOCS_ROOT> --project "<PROJECT NAME>" --target "<REPO ROOT>"
```

6. Add root README link if missing:
   - `## Documentation`
   - link to `<DOCS_ROOT>/README.md`

7. Report what was created:
   - docs root
   - `docflow.json`
   - `AGENTS.md`
   - `GEMINI.md`
   - `.cursorrules`

## Rules

- Never overwrite existing user-authored docs files.
- If docs already exist, prefer `docs-adopt` over `docs-init`.
- Keep `AGENTS.md` and `docflow.json` aligned on docs root.
- After scaffold, use `docs-author` for new docs, `docs-changelog` for shipped work, and `docs-repair` after renames.
