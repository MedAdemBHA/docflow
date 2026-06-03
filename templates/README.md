<!-- docflow: docs-root map. Keep short. Every durable doc gets one line here. -->
# <PROJECT> — Documentation

> Last updated: <YYYY-MM-DD>
> Rules: [NAMING.md](NAMING.md)

> Browse in a browser: `python3 -m http.server --directory docs` → open `index.html`.

## Open First

- Product: [product-spec/00-overview.md](product-spec/00-overview.md)
- Roadmap: [plans/upcoming/README.md](plans/upcoming/README.md)
- Latest shipped: [changelog/(mmm-yy).md](<changelog/(mmm-yy).md>)

## Tree

```
docs/
├── README.md            ← map
├── NAMING.md            ← naming rules
├── changelog/           ← shipped by month
├── product-spec/        ← WHAT
├── specs/               ← HOW
├── references/          ← rules / guides
├── decisions/           ← WHY
├── plans/
│   ├── features/        ← feature status + feature log
│   ├── hygiene/         ← cleanup work
│   └── upcoming/        ← roadmap
└── reviews/
    ├── bugs/            ← bug catalog
    ├── active/          ← active audits
    └── archive/         ← old audits
```

## Recent

- [`changelog/(mmm-yy).md`](<changelog/(mmm-yy).md>) — <one-line highlight>

## Product Spec
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
- Features: [<feature>](<plans/features/(mmm-yy)-<feature>.md>) — status + feature log

## Reviews
- [Bug catalog](reviews/bugs/open.md) — open · [fixed](reviews/bugs/fixed.md)
- Audits: [active/](reviews/) · [archive/](reviews/)
