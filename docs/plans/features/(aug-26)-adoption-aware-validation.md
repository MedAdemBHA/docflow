<!-- docflow: feature doc. Real-repository validation compatibility and upgrade safety. -->
# Feature — Adoption-Aware Validation

> **Status (2026-08-12):** shipped
> **Owner:** Maintainer
> **Surface:** validation, adoption, repair, context hook, integration tests

DocFlow should remain strict for repositories it creates while respecting established documentation systems it adopts. The two audited applications showed that navigation works well, but exact template enforcement and missing helper upgrades make real installations look broken.

Reference docs:
- Product: [`product-spec/00-overview.md`](../../product-spec/00-overview.md)
- Spec: [`specs/(aug-26)-adoption-aware-validation.md`](<../../specs/(aug-26)-adoption-aware-validation.md>)
- Baseline validation: [`specs/(jun-26)-document-validation.md`](<../../specs/(jun-26)-document-validation.md>)

## In flight

| Item | Status |
|---|---|
| Strict and adopted validation profiles | shipped |
| Code-aware placeholder and link detection | shipped |
| Upgrade-safe helper refresh | shipped |
| Concise newest-changelog context | shipped |
| Realistic adopted-repository regression fixtures | shipped |
| Plugin manifest and skill validation | shipped |

## Feature log

| Date | Change | Ref |
|---|---|---|
| 2026-08-12 | Converted the two-project audit into an implementation scope and severity policy. | local |
| 2026-08-12 | Shipped the profile-aware validator, managed-helper upgrade path, concise context hook, and regression coverage. | local |

## Next

1. Collect more adopted-repository fixtures and tune warning summaries only when they expose a repeated real-world pattern.
2. Publish `0.3.0` after review and reinstall it from a working local Codex marketplace/CLI.
