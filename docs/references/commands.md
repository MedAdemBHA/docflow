<!-- docflow: reference. Command, skill, and helper script catalog. -->
# Commands

After installing the plugin, everything lives under one namespace: `/docflow:<verb>`.
Type `/docflow:` in Claude Code to see them all. The setup/authoring entries are
**skills** — you can type the command *or* just ask in plain English (e.g. "is docflow
set up here?") and the matching skill triggers automatically. The three generators take
free-text arguments.

## Commands & skills

| Need | Command | Also triggers on (plain English) | Output |
|------|---------|----------------------------------|--------|
| Check readiness | `/docflow:check` | "is docflow set up", "what do I do next" | One status: ready / needs setup / adoption / repair / blocked |
| Inspect a repo | `/docflow:doctor` | "check docs setup", "doctor" | Read-only recommendation: init, adopt, repair, or OK |
| Start empty docs | `/docflow:init` | "set up docflow", "scaffold docs" | `docs/`, `docflow.json`, guidance files, helpers |
| Adopt existing docs | `/docflow:adopt` | "adopt my docs into docflow" | Missing infrastructure added; existing docs preserved |
| Repair generated files | `/docflow:repair` | "regenerate the docs map" | Fresh `docs/INDEX.md`, installed/refreshed managed helpers, link/placeholder report |
| Validate docs | `/docflow:validate` | "validate the docs" | Profile-aware blockers plus warning-only adoption cleanup |
| Find the right doc | `/docflow:router` | "where is X documented", "what's the roadmap" | Routes a question to one doc |
| Write a doc | `/docflow:author` | "write a doc", "add an ADR" | New doc in the right folder with the right name |
| Record shipped work | `/docflow:changelog` | "what changed", "add to changelog" | Entry in the monthly changelog |
| Plan feature work | `/docflow:feature-plan <msg>` | — | `docs/plans/features/(mmm-yy)-<slug>.md` |
| Write product behavior | `/docflow:product-spec <msg or code path>` | — | `docs/product-spec/00-overview.md` or `NN-<topic>.md` |
| Draft from repo signals | `/docflow:scan` | — | Auto-draft spec and roadmap candidates |

After updating a local plugin, run `/reload-plugins` if new commands do not autocomplete.

## Examples

| Example | Use when |
|---------|----------|
| `/docflow:doctor` | You just opened a repo and need the right setup path |
| `/docflow:check` | You want one answer: is docflow usable, and what's next |
| `/docflow:validate` | You changed docs and need to know whether anything blocks completion |
| `/docflow:feature-plan add team comments to documents` | You know the feature idea and need a status/log doc |
| `/docflow:product-spec src/features/comments` | Code exists and product WHAT docs should be drafted from it |
| `/reload-plugins` | You updated the local plugin but new commands do not autocomplete |

## Codex Skills

| Skill | Use it for |
|-------|------------|
| `check` | One-screen readiness status and next command |
| `doctor` | Same read-only diagnosis as `/docflow:doctor` |
| `init` | Initialize when doctor recommends init |
| `adopt` | Adopt existing docs without overwriting |
| `repair` | Safe generated-file maintenance and managed-helper upgrades |
| `validate` | Read-only strict/adopted validation gate for links, map freshness, metadata, update logs, and blockers |
| `router` | Route questions to the right doc before editing |
| `author` | Author product specs, technical specs, ADRs, reviews, and plans |
| `changelog` | Add shipped work to monthly changelog |

## Bash Scripts

The skills and commands above call these helper scripts. You can also run them directly
in any agent or shell. Script names are stable and unchanged.

| Script | Safe to run anytime? | Purpose |
|--------|----------------------|---------|
| `scripts/docflow-check.sh --target <repo>` | Yes | One-screen readiness status and next command |
| `scripts/docflow-doctor.sh --target <repo>` | Yes | Read-only repo diagnosis |
| `scripts/scaffold.sh --target <repo> --docs-root docs --project "Name" [--validation-profile strict\|adopted]` | New docs setup only | Create full docflow tree without overwriting files |
| `scripts/docflow-adopt.sh --target <repo> --docs-root docs --project "Name"` | Explicit setup only | Create missing infrastructure around existing docs |
| `scripts/docflow-repair.sh --target <repo>` | Yes for docflow repos | Regenerate map, refresh managed helpers, and report issues |
| `scripts/docflow-validate.sh --target <repo> [--profile strict\|adopted]` | Yes | Validate docs readiness and exit non-zero on blockers |
| `scripts/docflow-spec.sh <code-path> --target <repo>` | Draft only | Generate a technical spec draft from source files |
| `scripts/docflow-plan.sh --target <repo> --days 30` | Draft only | Generate roadmap candidates from TODO/FIXME markers and git churn |
| `scripts/docflow-map.sh docs` | Yes | Regenerate `docs/INDEX.md` |
| `scripts/check-links.sh docs` | Yes | Report broken local Markdown links |
