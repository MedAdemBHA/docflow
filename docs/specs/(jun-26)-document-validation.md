<!-- docflow: technical spec. HOW document validation works. -->
# Document Validation — Technical Specification

**Module:** `scripts/docflow-validate.sh`, `skills/validate/`
**Entry:** `/docflow:validate` (or just ask — the `validate` skill triggers)

## Architecture

| Component | Role |
|-----------|------|
| Validator script | Resolves docs root, scans Markdown files, prints errors/warnings, and sets the exit code |
| Doctor integration | Runs validation read-only and summarizes pass/fail without changing doctor exit behavior |
| Scaffold/repair wiring | Installs `docflow-validate.sh` into target repos with the other helper scripts |
| Command/skill wrappers | Tell Claude and Codex to run validation before reporting docs complete |

## Data

| Signal | Source | Severity |
|--------|--------|----------|
| Broken local links | `check-links.sh` output | Error |
| Stale `INDEX.md` | Generated map comparison | Error |
| Missing H1 | Markdown scan | Error |
| Unsupported category path | Relative doc path | Error |
| Placeholder leakage | Known template tokens outside template paths | Error |
| Template placeholders | Fresh scaffold/template paths | Warning |
| Missing metadata comment | `<!-- docflow: ... -->` absence | Warning |
| Missing update log | Content docs without `## Update Log` or feature/changelog log | Warning |

## API

| Surface | Behavior |
|---------|----------|
| `bash scripts/docflow-validate.sh --target <repo>` | Validates repo docs root from `docflow.json` or common docs folders |
| `--docs-root <root>` | Overrides docs root detection |
| Exit `0` | No validation errors |
| Exit `1` | One or more blocking errors |
| Exit `2` | Invalid command usage or target access failure |

## Flow

1. Resolve target and docs root.
2. Compare current `INDEX.md` to an in-memory generated map.
3. Run the existing local link checker.
4. Scan every Markdown file for H1, path category, metadata, placeholders, update logs, and required sections.
5. Print `Status`, `Errors`, and `Warnings`.
6. Return a non-zero exit only when `Errors` is non-empty.

## Risks

| Risk | Mitigation |
|------|------------|
| Adopted legacy docs lack metadata | Report as warnings first, not blockers |
| Fresh scaffold contains placeholders | Warn for known template paths while blocking placeholder leakage elsewhere |
| Command docs use angle-bracket arguments | Skip placeholder checks for stable references and naming docs |
| Validation drifts from map generation | Reuse the same H1/path algorithm as `docflow-map.sh` |

Related:
- Product spec: [`product-spec/00-overview.md`](../product-spec/00-overview.md)
- Plan: [`plans/features/(jun-26)-document-validation.md`](<../plans/features/(jun-26)-document-validation.md>)
- Review: [`reviews/README.md`](../reviews/README.md)
- Decisions: [ADR 0001](../decisions/0001-plain-markdown-bash.md)

## Update Log

| Date | Change | Ref |
|------|--------|-----|
| 2026-06-14 | Added validation gate specification. | `docflow-validate` |
| 2026-08-12 | Superseded exact-template enforcement for established repositories with the adopted profile defined in the adoption-aware validation spec. | `adoption-aware-validation` |
