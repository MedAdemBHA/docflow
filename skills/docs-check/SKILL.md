---
name: docs-check
description: "Friendly DocFlow readiness check. Gives one status, one reason, and the exact next command: init, adopt, repair, validate, or ready. Use when the user asks if docflow is set up, usable, clean, ready, or what to do next."
---

# docs-check

Goal: answer "is this usable and what do I do next?" in one screen.

## Run

```bash
bash scripts/docflow-check.sh --target <REPO ROOT>
```

If running from an installed plugin where scripts are not in the target repo, use the plugin script path.

## Interpret

| Status | Meaning | Next |
|--------|---------|------|
| `Ready` | DocFlow is installed and validation is clean | Start normal docs work |
| `Needs setup` | No meaningful docs or config detected | `docs-init` |
| `Needs adoption` | Existing docs need DocFlow infrastructure | `docs-adopt` |
| `Needs repair` | Generated helpers/guidance are missing | `docs-repair` |
| `Blocked` | Validation found hard errors | `docs-validate` |

## Rules

- Use this before asking the user to choose a setup path.
- Keep the response short: status, reason, next command.
- Do not run mutating commands from this skill; hand off to the matching skill.
