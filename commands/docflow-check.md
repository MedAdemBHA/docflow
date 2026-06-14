---
description: Show one DocFlow readiness status and the exact next action
---

Run the friendly DocFlow readiness check for this repo.

## Steps

1. Run check:
   ```bash
   bash "$CLAUDE_PROJECT_DIR/scripts/docflow-check.sh" --target "$CLAUDE_PROJECT_DIR"
   ```
   If the target repo does not have `scripts/docflow-check.sh`, use:
   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/scripts/docflow-check.sh" --target "$CLAUDE_PROJECT_DIR"
   ```
2. Read the `status` line first:
   - `Ready` means no action is needed.
   - `Needs setup` means run `/docflow:docflow-init`.
   - `Needs adoption` means run `/docflow:docflow-adopt`.
   - `Needs repair` means run `/docflow:docflow-repair`.
   - `Blocked` means run `/docflow:docflow-validate` and fix the listed errors.
3. Treat non-`Ready` as not complete yet.

## Report

Return:

- status
- reason
- next command
- top validation errors, if blocked
