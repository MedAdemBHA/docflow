# docflow

**A living-docs knowledge base + changelog memory for any repo — as a Claude Code plugin.**

docflow gives any project a consistent documentation *system* and makes your AI agent **start every session knowing what recently changed**. It packages a battle-tested doc taxonomy, naming rules, ADR/spec/plan/changelog templates, three teaching skills, and a SessionStart hook that auto-loads the docs index + newest changelog into the agent's context.

> The "way of documenting" is generic — extracted from a real production knowledge base and stripped of project specifics. Drop it into any repo.

---

## Why

Docs rot because there's no *system*: no agreed place for each kind of doc, no naming discipline, and — critically — no memory. An AI agent (or a new teammate) starts cold every time, blind to the last three months of decisions.

docflow fixes both:
- **Structure** — 7 categories, each answering one question (WHAT / HOW / WHY / conventions / roadmap / quality / history).
- **Memory** — an append-only monthly changelog, auto-surfaced to the agent at session start.

## The 7 categories

| Folder | Answers | Naming |
|--------|---------|--------|
| `product-spec/` | WHAT a feature does (user-facing) | `NN-topic.md` |
| `specs/` | HOW it's built | `(mmm-yy)-topic.md` |
| `decisions/` | WHY we chose an approach (ADRs) | `NNNN-title.md` |
| `references/` | conventions / cheat sheets | `topic.md` |
| `plans/` | roadmap + feature status | `(mmm-yy)-name.md`, `upcoming/*` |
| `reviews/` | quality + bug catalog | `(mmm-yy)-topic.md`, `bugs/` |
| `changelog/` | WHAT shipped, by month (append-only) | `(mmm-yy).md` |

Full naming rules ship in `templates/NAMING.md`.

## What's in the plugin

```
docflow/
├── .claude-plugin/        # plugin.json (+ SessionStart hook) + marketplace.json
├── skills/
│   ├── docs-router/       # READ  — route a question to the right doc
│   ├── docs-author/       # WRITE — pick category, apply naming, fill template, cross-link
│   └── docs-changelog/    # HISTORY — capture shipped work, month by month
├── commands/docflow-init.md   # /docflow-init — scaffold the tree into a repo
├── templates/             # genericized skeletons for every category
├── hooks/docflow-context.sh   # SessionStart: load docs index + newest changelog
└── scripts/scaffold.sh    # the underlying scaffolder (idempotent)
```

## Install

```bash
# add this repo as a plugin marketplace, then install
/plugin marketplace add https://github.com/your-handle/docflow
/plugin install docflow
```

Or for local development, point the marketplace at the cloned folder:
```bash
/plugin marketplace add /path/to/docflow
/plugin install docflow
```

## Use

1. **Scaffold** a docs tree in your repo:
   ```
   /docflow-init
   ```
   Creates the 7-category tree under `docs/` (or your chosen root), drops the templates, and writes `docflow.json` so the hook knows where docs live.

2. **Write** docs the docflow way — invoke the `docs-author` skill (or just ask "where should this doc go / write an ADR for X").

3. **Record** shipped work — invoke `docs-changelog` (or "add to changelog / what shipped this month").

4. **Read** — `docs-router` maps any question to the right doc instead of grepping the tree.

### The auto-context hook

On every session start, `hooks/docflow-context.sh`:
- finds your docs root via `docflow.json` (or auto-discovers `docs/`, `docsAdem/`, … containing a `changelog/`),
- injects the docs README index + the **newest** changelog month into the agent's context,
- stays completely silent in repos that don't use docflow.

That's the "always has context of old changes" guarantee — no prompting needed.

## Configuration — `docflow.json`

At your repo root:
```json
{
  "docsRoot": "docs",
  "changelogDir": "docs/changelog"
}
```
`changelogDir` is optional (defaults to `docsRoot/changelog`). `docsRoot` may be relative or absolute.

## Sharing docs on GitHub (no Claude Code needed)

- The `docs/README.md` index renders on GitHub with clickable relative links.
- Add a `## Documentation` section to your root README pointing at it.
- Optional: GitHub Pages (MkDocs/Docusaurus) or a Wiki for a full site.

## License

MIT — see [LICENSE](LICENSE).
