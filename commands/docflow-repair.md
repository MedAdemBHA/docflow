---
description: Regenerate the docs map, reinstall helpers, and report broken links/placeholders
---

You are repairing an existing docflow setup.

## Steps

1. Run repair:
   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/scripts/docflow-repair.sh" --target "$CLAUDE_PROJECT_DIR"
   ```

2. Report:
   - generated `INDEX.md`
   - installed helper scripts
   - broken links, if any
   - placeholder docs, if any

## Rules

- Only safe mutations are allowed: regenerate `INDEX.md` and install missing helper scripts.
- Do not rewrite content docs, README, ADRs, changelog months, or plans.
- If broken links or placeholders are found, report them; do not fix content unless the user asks.
