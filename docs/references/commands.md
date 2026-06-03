# Commands

## Claude Code

| Command | Purpose |
|---------|---------|
| `/docflow-doctor` | Inspect repo docs state without changing files |
| `/docflow-init` | Scaffold docflow when doctor finds no meaningful docs |
| `/docflow-adopt` | Safely add docflow around existing docs |
| `/docflow-repair` | Regenerate map, check links, report placeholders |
| `/docflow-feature-plan <msg>` | Create or update a feature plan from a short feature request |
| `/docflow-product-spec <msg or code path>` | Create or update product WHAT docs from a brief or code path |

## Codex Skills

| Skill | Purpose |
|-------|---------|
| `docs-doctor` | Same read-only diagnosis as `/docflow-doctor` |
| `docs-init` | Initialize when doctor recommends init |
| `docs-adopt` | Adopt existing docs without overwriting |
| `docs-repair` | Safe generated-file maintenance |
| `docs-router` | Route questions to the right doc |
| `docs-author` | Author specs, ADRs, reviews, and plans |
| `docs-changelog` | Add shipped work to monthly changelog |

## Bash Scripts

| Script | Safe to run anytime? | Purpose |
|--------|----------------------|---------|
| `scripts/docflow-doctor.sh --target <repo>` | Yes | Read-only repo diagnosis |
| `scripts/docflow-adopt.sh --target <repo> --docs-root docs --project "Name"` | Explicit setup only | Create missing infrastructure around existing docs |
| `scripts/docflow-repair.sh --target <repo>` | Yes for docflow repos | Regenerate map and report issues |
| `scripts/scaffold.sh --target <repo> --docs-root docs --project "Name"` | New docs setup only | Create full docflow tree without overwriting files |
| `scripts/docflow-map.sh docs` | Yes | Regenerate `docs/INDEX.md` |
| `scripts/check-links.sh docs` | Yes | Report broken local Markdown links |
