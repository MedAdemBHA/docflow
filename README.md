# docflow

**A practical docs system for any repo: structured markdown docs, monthly changelog memory, Claude plugin support, and native Codex plugin support.**

docflow gives any project a consistent documentation *system* and makes your AI agent **start each session with recent project context**. It ships a 7-folder docs taxonomy, naming rules, ADR/spec/plan/changelog templates, Claude skills + auto-context hook, a native Codex plugin manifest, and root-level guidance files for Codex/Gemini/Cursor.

> The "way of documenting" is generic — extracted from a real production knowledge base and stripped of project specifics. Drop it into any repo.

## What You Get

- A consistent docs tree for specs, ADRs, plans, reviews, references, and changelog history.
- A monthly append-only changelog so agents and humans can see what changed recently.
- Claude support via plugin skills and a `SessionStart` hook.
- Codex support via a native plugin manifest plus a scaffolded `AGENTS.md` that points the agent to the docs index and newest changelog month.

## Quick Start

1. Install `docflow` in your agent:
   - Claude:
     ```bash
     /plugin marketplace add https://github.com/MedAdemBHA/docflow
     /plugin install docflow
     ```
   - Codex:
     - use this repo as a native plugin source via [`.codex-plugin/plugin.json`](.codex-plugin/plugin.json)
     - after it is available in a Codex marketplace, install with:
       ```bash
       codex plugin add docflow@<marketplace-name>
       ```
2. Run the init flow:
   - Claude: `/docflow-init`
   - Codex: use the `docs-init` skill
3. Commit the generated docs tree and root guidance files.
4. Tell your agent to follow the repo docs. In Codex, `AGENTS.md` covers this automatically.

After scaffold, your repo gets:

- `<DOCS_ROOT>/` with the full 7-category docs tree and templates
- `docflow.json` with the docs root config
- `AGENTS.md` for Codex and other repo-aware agents
- `GEMINI.md` and `.cursorrules` as lightweight pointers back to `AGENTS.md`

## How It Works By Agent

| Agent | What docflow uses | Behavior |
|-------|-------------------|----------|
| Claude Code | `.claude-plugin`, skills, `SessionStart` hook | Auto-loads docs index + newest changelog into context |
| Codex | `.codex-plugin`, skills, `AGENTS.md` | Can install as a native Codex plugin, then follows the docs index + newest changelog workflow |
| Gemini / Cursor | `GEMINI.md`, `.cursorrules`, `AGENTS.md` | Reuses the same repo guidance path |

The docs system itself is plain markdown plus bash, so the structure is cross-agent even though the context-loading mechanism differs.

`AGENTS.md` is intentionally short and token-light. Put the routing rules there; keep the long explanation in `README.md`.

## Why

Docs rot because there's no *system*: no agreed place for each kind of doc, no naming discipline, and no memory. An AI agent or new teammate starts cold every time, blind to recent decisions.

docflow fixes both:
- **Structure** — 7 categories, each answering one question (WHAT / HOW / WHY / conventions / roadmap / quality / history).
- **Memory** — an append-only monthly changelog, surfaced automatically for Claude and routed explicitly via `AGENTS.md` for other agents.

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

## What's in the repo

```
docflow/
├── .claude-plugin/        # Claude plugin manifest + SessionStart hook
├── .codex-plugin/         # Codex plugin manifest
├── repo-templates/        # AGENTS.md + GEMINI.md + .cursorrules scaffolds
├── skills/
│   ├── docs-init/         # INIT  — scaffold docflow into a repo
│   ├── docs-router/       # READ  — route a question to the right doc
│   ├── docs-author/       # WRITE — pick category, apply naming, fill template, cross-link
│   └── docs-changelog/    # HISTORY — capture shipped work, month by month
├── commands/docflow-init.md   # /docflow-init — scaffold the tree into a repo
├── templates/             # genericized skeletons for every category
├── hooks/docflow-context.sh   # SessionStart: load docs index + newest changelog
└── scripts/scaffold.sh    # the underlying scaffolder (idempotent)
```

## Install

### Claude

```bash
/plugin marketplace add /path/to/docflow
/plugin install docflow
```

Or:

```bash
/plugin marketplace add https://github.com/MedAdemBHA/docflow
/plugin install docflow
```

### Codex

This repo ships a native Codex plugin manifest at [`.codex-plugin/plugin.json`](.codex-plugin/plugin.json).

Use it in one of these ways:

- add the repo to your local Codex plugin directory / marketplace flow
- publish it through a Codex marketplace

Then install:

```bash
codex plugin add docflow@<marketplace-name>
```

## Agent Setup

Use this split:

| Agent | Native plugin? | Native skills? | Repo file to read | What to set up |
|-------|----------------|----------------|-------------------|----------------|
| Claude Code | Yes | Yes | `docs/README.md` after scaffold | Install plugin from this repo, then use `/docflow-init` |
| Codex | Yes | Yes | `AGENTS.md` | Install native Codex plugin, then use `docs-init` |
| Gemini | No repo-native docflow plugin here | No docflow skill package here | `GEMINI.md` → `AGENTS.md` | Scaffold repo, keep `GEMINI.md` stub committed |
| Cursor | No repo-native docflow plugin here | No docflow skill package here | `.cursorrules` → `AGENTS.md` | Scaffold repo, keep `.cursorrules` stub committed |

Meaning:

- `Claude` and `Codex` get actual plugin/skill support from this repo.
- `Gemini` and `Cursor` do not use the same plugin format here. They follow repo guidance through markdown files.
- The portable part is the docs tree plus `AGENTS.md` routing, not one universal plugin manifest.

Files used by each agent:

- `Claude`: `.claude-plugin/plugin.json`, `skills/`, `commands/docflow-init.md`, `hooks/docflow-context.sh`
- `Codex`: `.codex-plugin/plugin.json`, `skills/`, `repo-templates/AGENTS.md`
- `Gemini`: `repo-templates/GEMINI.md`
- `Cursor`: `repo-templates/.cursorrules`

## Typical Workflow

1. **Scaffold** a docs tree in your repo:
   ```
   /docflow-init
   ```
   In Claude, use `/docflow-init`. In Codex, use the `docs-init` skill. Both create the 7-category tree under `docs/` (or your chosen root), drop the templates, write `docflow.json`, and add `AGENTS.md` plus optional `GEMINI.md` / `.cursorrules` stubs at the repo root.

2. **Write** docs the docflow way:
   - Use `docs-author` in Claude, or
   - Ask your agent to create/update the right doc under the docflow taxonomy.

3. **Record** shipped work:
   - Use `docs-changelog`, or
   - Update the current month in `changelog/(mmm-yy).md`.

4. **Read**:
   - Use `docs-router`, or
   - Start from `<DOCS_ROOT>/README.md` and follow links.

## Usage Guidelines

Use docflow as an operating rule, not just a folder scaffold.

1. Before substantial work, read `<DOCS_ROOT>/README.md` and the newest file in `<DOCS_ROOT>/changelog/`.
2. When documenting, choose the folder by question:
   - `product-spec/` = what the feature does for users
   - `specs/` = how it is implemented
   - `decisions/` = why a technical/product decision was made
   - `references/` = conventions, cheatsheets, stable guidance
   - `plans/` = work that is planned or in progress
   - `reviews/` = audits, bugs, quality findings
   - `changelog/` = what shipped
3. Follow `NAMING.md` exactly. The filename is part of the system.
4. Every durable doc should be linked from `<DOCS_ROOT>/README.md`.
5. Every shipped change should land in the current monthly changelog.

Use these rules of thumb:

- New feature behavior or user flow changed: update `product-spec/`.
- Implementation details matter for future maintainers: add or update `specs/`.
- A choice needs justification or tradeoff history: write an ADR in `decisions/`.
- Team conventions or setup instructions keep repeating: add a `references/` doc.
- Work is planned, staged, or being tracked over time: update `plans/`.
- Bugs, audits, or quality findings need to stay visible: use `reviews/`.
- Something shipped this month: append it to `changelog/(mmm-yy).md`.

Avoid these common mistakes:

- Don't put implementation detail in `product-spec/`.
- Don't use the changelog as a replacement for specs or ADRs.
- Don't create orphan docs that are not linked from the docs index.
- Don't rewrite old changelog months except to correct factual mistakes.
- Don't invent filenames ad hoc; use the naming patterns.

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

## Important Limitation

docflow is not one universal plugin runtime.

- Claude uses plugin hooks and skills.
- Codex uses a native plugin manifest, plugin skills, and repo guidance via `AGENTS.md`.
- Other agents may read `GEMINI.md` or `.cursorrules`, but they still rely on repo-level instructions.

So the portable part is the docs system and workflow, not a single shared plugin API.

## Sharing docs on GitHub (no Claude Code needed)

- The `docs/README.md` index renders on GitHub with clickable relative links.
- Add a `## Documentation` section to your root README pointing at it.
- Optional: GitHub Pages (MkDocs/Docusaurus) or a Wiki for a full site.

## License

MIT — see [LICENSE](LICENSE).
