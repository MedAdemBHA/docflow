---
description: Guide the agent to create or update a feature plan from a short feature request
argument-hint: <feature request>
---

Follow this prompt spec to create a docflow feature plan from this request:

```text
$ARGUMENTS
```

## Rules

- If the request is empty, ask for one short feature description and stop.
- Treat the request as the source brief, not as final truth. Infer sensible defaults, and mark unknowns as `TBD`.
- Create or update one plan file under `<DOCS_ROOT>/plans/features/`.
- Do not overwrite an existing feature plan blindly. If the target file exists, merge the new request into the existing `In flight`, `Feature log`, and `Next` sections.
- Keep output lean: tables and bullets, no filler.

## Steps

1. Find the docs root:
   - Read `docflow.json` from `$CLAUDE_PROJECT_DIR` if present and use `docsRoot`.
   - Otherwise use `docs`.
2. Read:
   - `<DOCS_ROOT>/README.md`
   - `<DOCS_ROOT>/NAMING.md`
   - `${CLAUDE_PLUGIN_ROOT}/templates/plans/features/(mmm-yy)-feature-name.md`
3. Derive:
   - feature name from `$ARGUMENTS`
   - kebab-case slug
   - month prefix from the current date: `(mmm-yy)`
   - target path: `<DOCS_ROOT>/plans/features/(mmm-yy)-<slug>.md`
4. Write the plan using this shape:
   ```markdown
   # Feature — <Name>

   > **Status (<YYYY-MM-DD>):** proposed
   > **Owner:** TBD
   > **Surface:** `<code path or TBD>`

   <2-3 lines: scope, users, current goal.>

   Reference docs:
   - Product: TBD
   - Spec: TBD

   Decisions:
   - TBD

   ## In flight

   | Item | Status |
   |------|--------|
   | <item> | proposed |

   ## Feature log

   | Date | Change | Ref |
   |------|--------|-----|
   | <YYYY-MM-DD> | Created feature plan from request: `<short request>` | `/docflow-feature-plan` |

   ## Next

   1. <next step>
   ```
5. If the request changes product behavior, note that `product-spec/` should be updated.
6. If the request implies implementation architecture, note that `specs/` should be updated.
7. Regenerate the docs map:
   ```bash
   bash "$CLAUDE_PROJECT_DIR/scripts/docflow-map.sh" "$CLAUDE_PROJECT_DIR/$DOCS_ROOT"
   ```
   If the target repo does not have `scripts/docflow-map.sh`, use:
   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/scripts/docflow-map.sh" "$CLAUDE_PROJECT_DIR/$DOCS_ROOT"
   ```
8. Run link check if available:
   ```bash
   bash "$CLAUDE_PROJECT_DIR/scripts/check-links.sh" "$CLAUDE_PROJECT_DIR/$DOCS_ROOT"
   ```

## Report

Return:

- plan file path
- whether it was created or updated
- product/spec docs that still need follow-up, if any
