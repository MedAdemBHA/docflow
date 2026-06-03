# Agent Guide

Repo use `docflow`.

Start here:

1. Read [`docs/README.md`](<docs/README.md>).
2. Read newest file in [`docs/changelog/`](<docs/changelog/>).
3. Then code.

New feature flow:

1. Add/update `product-spec/` for WHAT.
2. Add/update `specs/` for HOW.
3. Add/update `plans/features/` for status + feature log.
4. Append shipped work to current `changelog/(mmm-yy).md`.

Route by question:

- WHAT feature do: `docs/product-spec/`
- HOW built: `docs/specs/`
- WHY chose it: `docs/decisions/`
- Rules / conventions: `docs/references/`
- Planned / in progress: `docs/plans/`
- Bugs / audits / quality: `docs/reviews/`
- What shipped: `docs/changelog/`

Rules:

- Follow [`docs/NAMING.md`](<docs/NAMING.md>).
- Keep `docs/README.md` updated. Durable doc go there.
- `changelog/` append-only. Add current month if missing. Do not rewrite old months except factual fix.
- If work change behavior, architecture, decision, plan, or known issue, update docs.
- Prefer docs before code for behavior, architecture, decisions, roadmap, known issues.
