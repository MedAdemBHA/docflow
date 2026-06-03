---
description: Guide the agent to create or update product-spec docs from a feature brief or code path
argument-hint: <feature brief or code path>
---

Follow this prompt spec to create a docflow product spec from this source:

```text
$ARGUMENTS
```

## Rules

- If the source is empty, ask for one short feature brief or code path and stop.
- Product specs are WHAT docs: user behavior, user value, capabilities, scope.
- Keep HOW details out of `product-spec/`; put implementation notes in `specs/` follow-ups.
- Treat code as evidence, not product truth. If behavior or user intent is unclear, write `TBD`.
- Do not overwrite an existing product spec blindly. If a target file exists, merge new facts into the right sections.
- Keep output lean: tables and bullets, no filler.

## Steps

1. Find the docs root:
   - Read `docflow.json` from `$CLAUDE_PROJECT_DIR` if present and use `docsRoot`.
   - Otherwise use `docs`.
2. Read:
   - `<DOCS_ROOT>/README.md`
   - `<DOCS_ROOT>/NAMING.md`
   - `${CLAUDE_PLUGIN_ROOT}/templates/product-spec/00-overview.md`
   - `${CLAUDE_PLUGIN_ROOT}/templates/product-spec/NN-topic.md`
3. Inspect the source:
   - If `$ARGUMENTS` is a real file or directory, read the relevant README, package metadata, route/component filenames, exported names, and nearby tests.
   - If `$ARGUMENTS` is prose, use it as the source brief.
4. Choose the target:
   - Use `<DOCS_ROOT>/product-spec/00-overview.md` when the request describes the whole app, onboarding, project purpose, or missing overview content.
   - Otherwise create/update the next stable module doc: `<DOCS_ROOT>/product-spec/NN-<slug>.md`.
   - Pick `NN` as the next unused two-digit number in `product-spec/`.
5. Write the product spec:
   - For overview docs, include app name, type, stack if known, users, and core modules.
   - For module docs, include purpose, key actions, business value, links, and known constraints.
   - Use `TBD` instead of guessing missing users, owner, business value, or behavior.
6. Add cross-links:
   - Link to related `specs/` docs if they already exist.
   - Link to related `plans/features/` docs if they already exist.
   - Leave `TBD` links when follow-up docs do not exist yet.
7. Update `<DOCS_ROOT>/README.md` so the new product spec is discoverable.
8. If implementation details were discovered but no matching spec exists, report the needed `specs/(mmm-yy)-<topic>.md` follow-up.
9. Regenerate the docs map:
   ```bash
   bash "$CLAUDE_PROJECT_DIR/scripts/docflow-map.sh" "$CLAUDE_PROJECT_DIR/$DOCS_ROOT"
   ```
   If the target repo does not have `scripts/docflow-map.sh`, use:
   ```bash
   bash "${CLAUDE_PLUGIN_ROOT}/scripts/docflow-map.sh" "$CLAUDE_PROJECT_DIR/$DOCS_ROOT"
   ```
10. Run link check if available:
   ```bash
   bash "$CLAUDE_PROJECT_DIR/scripts/check-links.sh" "$CLAUDE_PROJECT_DIR/$DOCS_ROOT"
   ```

## Report

Return:

- product spec path
- whether it was created or updated
- inferred facts vs `TBD` gaps
- spec/plan docs that still need follow-up, if any
