<!-- docflow: technical spec. HOW the bounded session context is loaded. -->
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

## Data

| Input | Purpose |
|---|---|
| `docflow.json` | Resolves the docs root, changelog directory, and validation profile |
| `docs/INDEX.md` | Compact `path - purpose` routing map |
| `docs/changelog/(mmm-yy).md` | Recent shipped-work memory |

## API

The hook is a shell entrypoint. It reads `CLAUDE_PROJECT_DIR` and supports optional `DOCFLOW_INDEX_LINES` and `DOCFLOW_LOG_LINES` limits. It writes documentation context to standard output and does not modify repository files.

## Flow

1. Exit silently when the repository has no `docflow.json`.
2. Resolve and validate configured documentation paths.
3. Emit at most 30 non-empty index lines by default.
4. Select the newest valid monthly changelog by filename date.
5. Emit its summary and newest entry within a 20-line default budget.

## Safety

- The hook is read-only.
- Output is truncated by `DOCFLOW_INDEX_LINES` and `DOCFLOW_LOG_LINES`.
- Repositories without `docflow.json` or docs stay silent.

## Risks

- A stale `INDEX.md` can route an agent incorrectly, so repair regenerates it.
- Small output limits can omit a relevant path in unusually large documentation maps.
- Changelog filenames must follow `(mmm-yy).md` for date ordering.

Related:

- Product spec: [overview](../product-spec/00-overview.md)
- Decision: [0001 session context hook](../decisions/0001-session-context-hook.md)
- Changelog: [jun-26](<../changelog/(jun-26).md>)

## Update Log

| Date | Change | Ref |
|---|---|---|
| 2026-06-03 | Documented the session context hook. | `docflow-init` |
| 2026-08-13 | Added complete data, API, flow, and risk contracts. | `demo-refresh` |
