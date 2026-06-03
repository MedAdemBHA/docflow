# Plugin Workflow — Technical Specification

**Module:** `scripts/`, `commands/`, `skills/`, `hooks/`
**Entry:** `/docflow-doctor`, `/docflow-init`, `/docflow-adopt`, `/docflow-repair`

## Architecture

| Layer | Files | Role |
|-------|-------|------|
| Bash backend | `scripts/docflow-*.sh`, `scaffold.sh`, `check-links.sh` | Shared implementation for all agents |
| Claude UX | `commands/docflow-*.md`, `.claude-plugin/plugin.json` | Slash commands and SessionStart hook |
| Codex UX | `.codex-plugin/plugin.json`, `skills/docs-*` | Skills and plugin manifest |
| Portable repo UX | `repo-templates/AGENTS.md`, `GEMINI.md`, `.cursorrules` | Agent guidance committed into target repos |
| Docs templates | `templates/` | Source skeletons copied during init/adopt |

## Flow

| Command | Mutation | Behavior |
|---------|----------|----------|
| doctor | none | Scans config, docs roots, guidance files, changelog months, helpers, placeholders, and links |
| init | safe create-only | Runs doctor first; scaffolds only when no meaningful docs exist |
| adopt | safe create-only | Adds missing docflow infrastructure around existing docs; writes an adoption review |
| repair | generated/helper only | Regenerates `INDEX.md`, installs missing helpers, reports links/placeholders |
| feature-plan | content doc | Uses the user's message as a source brief, then creates or merges a dated `plans/features/` status doc |
| product-spec | content doc | Uses a brief or code path as evidence, then creates or merges `product-spec/` WHAT docs with `TBD` for unclear product facts |
| context hook | none | Prints docs map and newest filename-sorted changelog month; exits `0` |

## Data and Config

| File | Contract |
|------|----------|
| `docflow.json` | `docsRoot` and `changelogDir`; parsed with grep/sed, not jq |
| `docs/INDEX.md` | Generated path-to-purpose map from first H1 in each Markdown file |
| changelog month | Filename `mmm-yy.md` or `(mmm-yy).md`; hook sorts by filename date, not mtime |
| root guidance | `AGENTS.md`, `GEMINI.md`, `.cursorrules` point agents at docs and changelog |

## Safety Rules

- Existing files are skipped, not overwritten.
- Placeholder replacement only runs on files created during the current scaffold.
- Doctor is read-only and exits `0` for normal repo states.
- Hook is read-only, token-light, and exits `0` on every path.
- Repair only mutates generated/helper files.

## Risks

| Risk | Mitigation |
|------|------------|
| Existing docs are messy | Doctor recommends adopt; adopt preserves all existing content |
| Old changelog file touched recently | Hook sorts by encoded filename date instead of mtime |
| Broken links from parenthesized filenames | `check-links.sh` supports angle-wrapped Markdown links |
| Agent install differs by platform | Scripts remain the common backend; commands/skills are wrappers |

Related:
- Product: [DocFlow overview](../product-spec/00-overview.md)
- Decision: [0001 plain Markdown and Bash](../decisions/0001-plain-markdown-bash.md)
- Reference: [Commands](../references/commands.md)
