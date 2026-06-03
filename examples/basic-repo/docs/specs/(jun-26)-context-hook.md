# Context Hook - Technical Specification

> Module: docflow context loading
> Route: Claude `SessionStart`
> Branch: `main`

## Architecture

| Step | Behavior |
|------|----------|
| 1 | Read `docflow.json` from the repository root |
| 2 | Resolve `docsRoot` and `changelogDir` |
| 3 | Print `docs/INDEX.md` if present |
| 4 | Print the newest non-template changelog month |

## Safety

- The hook is read-only.
- Output is truncated by `DOCFLOW_INDEX_LINES` and `DOCFLOW_LOG_LINES`.
- Repositories without `docflow.json` or docs stay silent.

## Related

- Product spec: [overview](../product-spec/00-overview.md)
- Decision: [0001 session context hook](../decisions/0001-session-context-hook.md)
- Changelog: [jun-26](<../changelog/(jun-26).md>)
