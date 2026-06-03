# docflow

[![CI](https://github.com/MedAdemBHA/docflow/actions/workflows/ci.yml/badge.svg)](https://github.com/MedAdemBHA/docflow/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

DocFlow is a lightweight documentation-memory system for AI coding agents. It scaffolds structured project docs, ADRs, plans, reviews, and monthly changelogs so Claude/Codex can start each session with the right project context.

> Status: early MVP developer tool. This is not a document approval, e-signature, or workflow-analytics SaaS.

## What It Does

- Creates a 7-folder documentation taxonomy for product behavior, implementation, decisions, references, plans, reviews, and changelog history.
- Adds a monthly append-only changelog so agents and humans can see what shipped recently.
- Provides Claude Code skills plus a read-only `SessionStart` hook that prints the docs map and newest real changelog entry.
- Provides a Codex plugin manifest and an `AGENTS.md` template for repo-aware agent guidance.
- Keeps everything as plain Markdown plus small Bash scripts.

## Demo

Example scaffold output is committed under [examples/basic-repo](examples/basic-repo/).

Minimal flow:

```bash
bash scripts/scaffold.sh --target /path/to/repo --docs-root docs --project "My App"
cd /path/to/repo
find docs -maxdepth 2 -type f | sort
CLAUDE_PROJECT_DIR="$PWD" bash /path/to/docflow/hooks/docflow-context.sh
```

Expected result:

- `docs/README.md` becomes the human-readable documentation index.
- `docs/INDEX.md` becomes the compact path-to-purpose map agents read first.
- `docs/changelog/` holds monthly shipped-work memory.
- `AGENTS.md` tells Codex and other repo-aware agents where to start.

## The 7 Categories

| Folder | Answers | Naming |
|--------|---------|--------|
| `product-spec/` | What a feature does for users | `NN-topic.md` |
| `specs/` | How it is built | `(mmm-yy)-topic.md` |
| `decisions/` | Why a choice was made | `NNNN-title.md` |
| `references/` | Rules, conventions, cheat sheets | `topic.md` |
| `plans/` | Roadmap and work status | `(mmm-yy)-name.md`, `upcoming/*` |
| `reviews/` | Quality, audits, known bugs | `(mmm-yy)-topic.md`, `bugs/` |
| `changelog/` | What shipped by month | `(mmm-yy).md` |

Full naming rules ship in [templates/NAMING.md](templates/NAMING.md).

## Install

### Claude Code

Install from a local checkout:

```bash
/plugin marketplace add /path/to/docflow
/plugin install docflow
```

Or from GitHub:

```bash
/plugin marketplace add https://github.com/MedAdemBHA/docflow
/plugin install docflow
```

Then initialize a repository:

```bash
/docflow-init
```

### Codex

This repository includes a Codex plugin manifest at [.codex-plugin/plugin.json](.codex-plugin/plugin.json), but there is no public Codex marketplace entry yet.

Use it today as a local/native plugin source:

1. Clone this repository.
2. Point your local Codex plugin source / marketplace flow at the repository root.
3. Codex reads [.codex-plugin/plugin.json](.codex-plugin/plugin.json) and the `skills/` directory from that local source.
4. In the target repository, run the `docs-init` skill or use the scaffold script directly.

Only after `docflow` is published to a Codex marketplace does this command become a ready-to-run install step:

```bash
codex plugin add docflow@<marketplace-name>
```

## Trust And Safety

docflow asks users to install an AI-agent plugin and run Bash. That deserves explicit proof.

- Read [SECURITY.md](SECURITY.md) before installing.
- CI runs `shellcheck` on scripts and hooks.
- CI runs [scripts/test-scaffold.sh](scripts/test-scaffold.sh), covering idempotency, special-character project names, JSON validity, link checks, and hook behavior.
- The Claude `SessionStart` hook is read-only and prints truncated docs context only.

Run checks locally:

```bash
bash scripts/test-scaffold.sh
shellcheck scripts/*.sh hooks/*.sh
```

## Repository Layout

```text
docflow/
├── .claude-plugin/          # Claude plugin manifest
├── .codex-plugin/           # Codex plugin manifest
├── .github/workflows/       # CI
├── commands/                # /docflow-init command
├── examples/basic-repo/     # Filled example output
├── hooks/                   # SessionStart context hook
├── repo-templates/          # AGENTS.md, GEMINI.md, .cursorrules
├── scripts/                 # scaffold, map, link check, smoke tests
├── skills/                  # docs-init/router/author/changelog
└── templates/               # generic docs skeletons
```

## Agent Support

| Agent | Support level | How it works |
|-------|---------------|--------------|
| Claude Code | Primary | Plugin skills plus read-only `SessionStart` context hook |
| Codex | Manifest + repo guidance | Codex plugin manifest, skills, and scaffolded `AGENTS.md` |
| Gemini / Cursor | Repo guidance | Scaffolded `GEMINI.md` and `.cursorrules` point back to `AGENTS.md` |

The portable product is the docs tree and workflow. The plugin runtime is agent-specific.

## Typical Workflow

1. Scaffold docflow into a repo.
2. Fill `docs/README.md` and `product-spec/00-overview.md`.
3. Write ADRs, specs, plans, and reviews using the category templates.
4. Append shipped work to the current monthly changelog.
5. Regenerate `docs/INDEX.md` with `bash scripts/docflow-map.sh docs`.
6. Run `bash scripts/check-links.sh docs`.

## GitHub Packaging Checklist

Before presenting this as a polished public tool:

- Add GitHub description: `Documentation memory for AI coding agents`.
- Add topics: `claude-code`, `codex`, `documentation`, `changelog`, `adr`, `ai-agents`, `developer-tools`.
- Publish the next tagged release from a passing CI commit.
- Add a short terminal recording or GIF of install, scaffold, and context loading.
- Verify and document the public Codex install path.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## Changelog

See [CHANGELOG.md](CHANGELOG.md).

## License

MIT - see [LICENSE](LICENSE).
