# Commands

Claude Code may expose commands as `/docflow:docflow-*` after plugin install. If un-namespaced `/docflow-*` commands appear in autocomplete, those are equivalent.

## Claude Code

| Need | Command | Output |
|------|---------|--------|
| Inspect a repo | `/docflow:docflow-doctor` | Read-only recommendation: init, adopt, repair, or OK |
| Start empty docs | `/docflow:docflow-init` | `docs/`, `docflow.json`, guidance files, helpers |
| Adopt existing docs | `/docflow:docflow-adopt` | Missing docflow infrastructure; existing docs preserved |
| Repair generated files | `/docflow:docflow-repair` | Fresh `docs/INDEX.md`, helper scripts, link/placeholder report |
| Plan feature work | `/docflow:docflow-feature-plan <msg>` | `docs/plans/features/(mmm-yy)-<slug>.md` |
| Write product behavior | `/docflow:docflow-product-spec <msg or code path>` | `docs/product-spec/00-overview.md` or `NN-<topic>.md` |
| Draft from repo signals | `/docflow:docflow-scan` | Auto-draft spec and roadmap candidates |

## Claude Examples

| Example | Use when |
|---------|----------|
| `/docflow:docflow-doctor` | You just opened a repo and need the right setup path |
| `/docflow:docflow-feature-plan add team comments to documents` | You know the feature idea and need a status/log doc |
| `/docflow:docflow-product-spec src/features/comments` | Code exists and product WHAT docs should be drafted from it |
| `/reload-plugins` | You updated the local plugin but new commands do not autocomplete |

## Codex Skills

| Skill | Use it for |
|-------|------------|
| `docs-doctor` | Same read-only diagnosis as `/docflow:docflow-doctor` |
| `docs-init` | Initialize when doctor recommends init |
| `docs-adopt` | Adopt existing docs without overwriting |
| `docs-repair` | Safe generated-file maintenance |
| `docs-router` | Route questions to the right doc before editing |
| `docs-author` | Author product specs, technical specs, ADRs, reviews, and plans |
| `docs-changelog` | Add shipped work to monthly changelog |

## Bash Scripts

| Script | Safe to run anytime? | Purpose |
|--------|----------------------|---------|
| `scripts/docflow-doctor.sh --target <repo>` | Yes | Read-only repo diagnosis |
| `scripts/scaffold.sh --target <repo> --docs-root docs --project "Name"` | New docs setup only | Create full docflow tree without overwriting files |
| `scripts/docflow-adopt.sh --target <repo> --docs-root docs --project "Name"` | Explicit setup only | Create missing infrastructure around existing docs |
| `scripts/docflow-repair.sh --target <repo>` | Yes for docflow repos | Regenerate map and report issues |
| `scripts/docflow-spec.sh <code-path> --target <repo>` | Draft only | Generate a technical spec draft from source files |
| `scripts/docflow-plan.sh --target <repo> --days 30` | Draft only | Generate roadmap candidates from TODO/FIXME markers and git churn |
| `scripts/docflow-map.sh docs` | Yes | Regenerate `docs/INDEX.md` |
| `scripts/check-links.sh docs` | Yes | Report broken local Markdown links |
