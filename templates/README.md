<!-- docflow: docs-root index / portal. This is the map. Keep it current — every new doc gets a line here. -->
# <PROJECT> — Documentation

> Last updated: <YYYY-MM-DD>
> Naming rules: see [NAMING.md](NAMING.md) — `(mmm-yy)-` prefix on dated docs, stable numbering on product-spec + ADRs.

## Layout

```
docs/
├── README.md            ← you are here (the map)
├── NAMING.md            ← file naming rules
├── changelog/           ← per-month shipped work (append-only history)
├── product-spec/        ← WHAT (user-facing features, by module)
├── specs/               ← HOW (technical implementation), grouped by feature
├── references/          ← cheat sheets, conventions, library guides
├── decisions/           ← ADRs — WHY we chose what we chose
├── plans/
│   ├── features/        ← in-progress feature work
│   ├── hygiene/         ← structural cleanup
│   └── upcoming/        ← roadmap by horizon (critical/now/next/later)
└── reviews/
    ├── bugs/            ← bug catalog (open + fixed)
    ├── active/          ← still-actionable audits
    └── archive/         ← superseded / shipped audits
```

**Recent:** <link the newest 1–2 changelog months + headline work here>
- [`changelog/(mmm-yy).md`](<changelog/(mmm-yy).md>) — <one-line highlight>

---

## Product Spec — start here
| # | Document | Scope |
|---|----------|-------|
| 0 | [Overview](product-spec/00-overview.md) | App identity, stack, high-level architecture |
| 1 | [<topic>](product-spec/01-<topic>.md) | <scope> |

## Specs
| Document | Description |
|----------|-------------|
| [<topic>](<specs/(mmm-yy)-<topic>.md>) | <description> |

## References
| Document | Description |
|----------|-------------|
| [<topic>](references/<topic>.md) | <description> |

## Decisions (ADRs)
| # | Title | Status |
|---|-------|--------|
| [0001](decisions/0001-<title>.md) | <title> | Accepted |

## Plans
- [Roadmap](plans/upcoming/README.md) — [critical](plans/upcoming/critical.md) / [now](plans/upcoming/now.md) / [next](plans/upcoming/next.md) / [later](plans/upcoming/later.md)
- Features: [<feature>](<plans/features/(mmm-yy)-<feature>.md>)

## Reviews
- [Bug catalog](reviews/bugs/open.md) — open · [fixed](reviews/bugs/fixed.md)
- Audits: [active/](reviews/) · [archive/](reviews/)
