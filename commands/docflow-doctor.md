---
description: Inspect repo documentation state and recommend init/adopt/repair without changing files
---

You are diagnosing whether this repository should use docflow.

## Steps

1. Run the read-only doctor:
   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/scripts/docflow-doctor.sh" --target "$CLAUDE_PROJECT_DIR"
   ```

2. Report the result using these headings:
   - `Status`
   - `Detected`
   - `Missing`
   - `Risks`
   - `Recommended next command`

3. Do not change files. If the recommendation is:
   - `/docflow-init`: repo has no meaningful docs yet.
   - `/docflow-adopt`: repo has docs or README and should preserve them.
   - `/docflow-repair`: docflow exists and needs maintenance.

## Rules

- Read-only only.
- Do not scaffold, adopt, repair, edit README, or generate docs from this command.
- Keep output token-light; show the script summary, not a full file tree.
