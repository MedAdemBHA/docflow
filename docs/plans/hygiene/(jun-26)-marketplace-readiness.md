<!-- docflow: hygiene plan. Marketplace listing readiness and CI scanner setup. -->
# Hygiene — Marketplace Readiness

> **Status (2026-06-14):** shipped

Goal: make DocFlow ready for `awesome-codex-plugins` submission requirements by adding the HOL scanner workflow and pinned GitHub Actions.

| # | Task | Status | Notes |
|---|------|--------|-------|
| 1 | Add HOL Plugin Scanner workflow | shipped | Uses scanner mode with minimum score `80` and high-severity failure gate |
| 2 | Pin existing checkout action | shipped | Existing CI now uses the v4.2.2 commit SHA |
| 3 | Extend CI test coverage | shipped | CI runs validation and readiness-check regression tests |
| 4 | Add Codex marketplace icon | shipped | Manifest now exposes `interface.composerIcon` for curated-list validation |

## Update Log

| Date | Change | Ref |
|------|--------|-----|
| 2026-06-14 | Added scanner workflow and CI hardening for marketplace readiness. | `.github/workflows/hol-plugin-scanner.yml` |
| 2026-06-14 | Added SVG composer icon for marketplace bundle validation. | `.codex-plugin/plugin.json` |
