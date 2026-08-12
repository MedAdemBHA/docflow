# Agent Guide

Repo use `docflow`.

Start here:

1. Read [`<DOCS_ROOT>/README.md`](<<DOCS_ROOT>/README.md>).
2. Read the summary and latest entry in the newest file under [`<DOCS_ROOT>/changelog/`](<<DOCS_ROOT>/changelog/>). Open older entries only when the task needs deeper history.
3. Then code.

New feature flow:

1. Add/update `product-spec/` for WHAT.
2. Add/update `specs/` for HOW.
3. Add/update `plans/features/` for status + feature log.
4. Append shipped work to current `changelog/(mmm-yy).md`.

Route by question:

- WHAT feature do: `<DOCS_ROOT>/product-spec/`
- HOW built: `<DOCS_ROOT>/specs/`
- WHY chose it: `<DOCS_ROOT>/decisions/`
- Rules / conventions: `<DOCS_ROOT>/references/`
- Planned / in progress: `<DOCS_ROOT>/plans/`
- Bugs / audits / quality: `<DOCS_ROOT>/reviews/`
- What shipped: `<DOCS_ROOT>/changelog/`

Rules:

- Follow [`<DOCS_ROOT>/NAMING.md`](<<DOCS_ROOT>/NAMING.md>).
- Keep `<DOCS_ROOT>/README.md` updated. Durable doc go there.
- `changelog/` append-only. Add current month if missing. Do not rewrite old months except factual fix.
- If work change behavior, architecture, decision, plan, or known issue, update docs.
- Prefer docs before code for behavior, architecture, decisions, roadmap, known issues.
