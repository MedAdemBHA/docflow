# DocFlow — Documentation

> Last updated: 2026-06-14
> Rules: [NAMING.md](NAMING.md)

## Open First

- Product: [product-spec/00-overview.md](product-spec/00-overview.md)
- Architecture: [specs/(jun-26)-plugin-workflow.md](<specs/(jun-26)-plugin-workflow.md>)
- Decision: [decisions/0001-plain-markdown-bash.md](decisions/0001-plain-markdown-bash.md)
- Roadmap: [plans/upcoming/README.md](plans/upcoming/README.md)
- Latest shipped: [changelog/(jun-26).md](<changelog/(jun-26).md>)

## Product Spec

| # | Document | Scope |
|---|----------|-------|
| 0 | [Overview](product-spec/00-overview.md) | Product identity, users, modules, and value |

## Specs

| Document | Description |
|----------|-------------|
| [Plugin workflow](<specs/(jun-26)-plugin-workflow.md>) | Doctor/adopt/repair/init flow, script backend, hook behavior, and agent surfaces |
| [Document validation](<specs/(jun-26)-document-validation.md>) | Validation gate, metadata/update-log checks, blocker severity, and command wrappers |

## References

| Document | Description |
|----------|-------------|
| [Commands](references/commands.md) | Local script, Claude command, and Codex skill command reference |
| [Glossary](references/glossary.md) | Shared terminology for docs, scripts, and agent UX |

## Commands

| Need | Command |
|------|---------|
| Check if DocFlow is ready | `/docflow:docflow-check` |
| Inspect repo docs | `/docflow:docflow-doctor` |
| Initialize empty docs | `/docflow:docflow-init` |
| Adopt existing docs | `/docflow:docflow-adopt` |
| Repair generated map/helpers | `/docflow:docflow-repair` |
| Validate docs before completion | `/docflow:docflow-validate` |
| Create a feature plan | `/docflow:docflow-feature-plan <msg>` |
| Draft product WHAT docs | `/docflow:docflow-product-spec <msg or code path>` |

## Decisions

| # | Title | Status |
|---|-------|--------|
| [0001](decisions/0001-plain-markdown-bash.md) | Plain Markdown and Bash as the portable core | Accepted |

## Plans

- [Roadmap](plans/upcoming/README.md) — [critical](plans/upcoming/critical.md) / [now](plans/upcoming/now.md) / [next](plans/upcoming/next.md) / [later](plans/upcoming/later.md)
- Features: [Clear command docs portal](<plans/features/(jun-26)-clear-command-docs-portal.md>) — README command clarity and clean browser portal
- Features: [Document validation and update logs](<plans/features/(jun-26)-document-validation.md>) — validation gate for metadata, update logs, links, maps, and blockers
- Features: [Friendly readiness check](<plans/features/(jun-26)-friendly-readiness-check.md>) — one-screen status and next command for usability
- Features: [Message-driven feature plan](<plans/features/(jun-26)-message-driven-feature-plan.md>) — `/docflow-feature-plan <msg>` status + feature log
- Features: [Message-driven product spec](<plans/features/(jun-26)-message-driven-product-spec.md>) — `/docflow-product-spec <msg or code path>` status + feature log

## Reviews

- [Current review](reviews/README.md) — scorecard and risks
- [Bug catalog](reviews/bugs/open.md) — open / [fixed](reviews/bugs/fixed.md)

## Changelog

- [June 2026](<changelog/(jun-26).md>) — initial release plus scaffold/context hardening
