<!-- docflow: technical spec. HOW adoption-aware validation and upgrades work. -->
# Adoption-Aware Validation And Upgrade Safety

**Module:** `scripts/docflow-validate.sh`, `scripts/scaffold.sh`, `scripts/docflow-adopt.sh`, `scripts/docflow-repair.sh`, `hooks/docflow-context.sh`
**Entry:** `validationProfile` in `docflow.json`, `/docflow:docflow-repair`, `/docflow:docflow-validate`

## Architecture

| Component | Role |
|---|---|
| Validation profile | Selects `strict` for DocFlow-native scaffolds or `adopted` for repositories with an established documentation system |
| Objective gates | Broken links, stale generated maps, and missing H1 headings remain blockers in every profile |
| Convention checks | Naming, taxonomy placement, required template sections, metadata, and update logs remain strict errors/warnings for native docs but become cleanup warnings where appropriate for adopted docs |
| Placeholder scanner | Removes fenced and inline code before inspecting placeholder tokens, avoiding false positives from examples such as `<status>` |
| Repair upgrader | Refreshes recognized DocFlow-owned helpers when plugin and repository copies differ; project content remains untouched |
| Context hook | Emits the compact map plus a bounded changelog summary/latest-entry slice |

## Data

`docflow.json` supports:

```json
{
  "docsRoot": "docs",
  "changelogDir": "docs/changelog",
  "validationProfile": "strict"
}
```

| Field | Values | Default for legacy configs |
|---|---|---|
| `validationProfile` | `strict`, `adopted` | `adopted`, preserving compatibility for repositories created before profiles existed |

Fresh initialization writes `strict`. Adoption writes `adopted`. Invalid values produce a configuration error.

## API

| Surface | Behavior |
|---|---|
| `scaffold.sh --validation-profile strict|adopted` | Writes the selected profile when creating `docflow.json` |
| `docflow-adopt.sh` | Always requests the `adopted` profile for a newly created config |
| `docflow-validate.sh` | Prints the active profile and applies its severity policy |
| `docflow-repair.sh` | Installs missing helpers and refreshes recognized DocFlow helper files |
| `DOCFLOW_CHANGELOG_LINES` | Optional hook override; default remains bounded |

## Flow

1. Resolve `docsRoot` and `validationProfile` from configuration.
2. Apply objective integrity gates in all profiles.
3. Strip fenced and inline code before placeholder inspection.
4. In `strict`, enforce the native taxonomy and required template sections.
5. In `adopted`, retain those findings as actionable warnings so established doc structures remain usable.
6. During repair, refresh only helper scripts whose header identifies them as DocFlow-managed.
7. Generate the compact index and report content issues without rewriting project-authored docs.

## Risks

| Risk | Mitigation |
|---|---|
| Adoption profile hides real breakage | Links, map freshness, and H1 integrity never downgrade |
| User-customized helper is overwritten | Refresh only files carrying a recognized `docflow` helper header; leave other existing scripts untouched |
| Old configuration has no profile | Default it to `adopted`; fresh scaffolds explicitly write `strict` |
| Long changelog consumes agent context | Emit a bounded summary/latest-entry window and guide agents to open full history only when needed |

Related:
- Product spec: [`product-spec/00-overview.md`](../product-spec/00-overview.md)
- Plan: [`plans/features/(aug-26)-adoption-aware-validation.md`](<../plans/features/(aug-26)-adoption-aware-validation.md>)
- Validation baseline: [`specs/(jun-26)-document-validation.md`](<(jun-26)-document-validation.md>)
- Decision: [`decisions/0001-plain-markdown-bash.md`](../decisions/0001-plain-markdown-bash.md)

## Update Log

| Date | Change | Ref |
|---|---|---|
| 2026-08-12 | Defined validation profiles, code-aware placeholder scanning, helper upgrades, and bounded changelog context. | `adoption-aware-validation` |
