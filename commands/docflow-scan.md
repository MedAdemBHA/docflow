---
description: Draft a technical spec and roadmap candidates from code, TODOs, and git history
---

Turn the actual codebase into doc drafts (not blank templates). Two generators; the draft is then verified + trimmed by you.

## Spec from a module
```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/docflow-spec.sh" <code-path> --target "$CLAUDE_PROJECT_DIR" --docs-root <DOCS_ROOT>
```
Scans the path → writes `<DOCS_ROOT>/specs/(mmm-yy)-<name>.md` pre-filled with: source file list, exported symbols (Architecture), interfaces/types/enums (Data), string paths + HTTP verbs (API), hooks/state (Flow). Add `--stdout` to preview without writing. Won't overwrite an existing spec.

**After generating:** verify the auto lists, group exports into the real component/service map, confirm which paths are real endpoints, and fill the **Risks** section (heuristics can't infer it).

## Plan candidates from repo signal
```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/docflow-plan.sh" --target "$CLAUDE_PROJECT_DIR" --docs-root <DOCS_ROOT> --days 30
```
Scans `TODO/FIXME/HACK/XXX` markers + git churn (last N days) → writes `<DOCS_ROOT>/plans/upcoming/(mmm-yy)-candidates.md`. It will not overwrite an existing candidates file unless `--force` is passed. Set `SCAN_DIR=src` to limit scope.

**After generating:** triage each candidate into `critical/now/next/later.md`, then delete the candidates file. Markers in high-churn areas → likely critical/now.

## Rules
- These produce **drafts**. Never ship an unverified auto-spec — the agent/dev curates first.
- Re-run after big code changes to refresh the discovered surface.
- Regenerate `INDEX.md` afterward: `bash "${CLAUDE_PLUGIN_ROOT}/scripts/docflow-map.sh" "$CLAUDE_PROJECT_DIR/<DOCS_ROOT>"`.
- Validate before reporting completion: `bash "${CLAUDE_PLUGIN_ROOT}/scripts/docflow-validate.sh" --target "$CLAUDE_PROJECT_DIR"`.
