<!-- docflow: monthly changelog. Append-only history. Outcome-first. -->
# June 2026 — Initial release

> Window: `76970f4` → `04101c5`. Scope: `7` commits.

## Summary

- **Release type:** feature
- **User impact:** Repos gain a structured, AI-readable docs+changelog memory across Claude, Codex, Gemini, and Cursor.
- **Tech impact:** New plugin: scaffold script, 7-category taxonomy, SessionStart hook, multi-agent guidance files, compact INDEX map.
- **Risk / follow-up:** None shipped; templates still placeholder until first real docs authored.

## What Changed

### 1. Core docflow plugin
| | |
|---|---|
| **Outcome** | Living-docs + changelog-memory system bootstrapped as a Claude Code plugin. |
| **Delivered** | 7-category docs tree; templates; `docflow.json` config; SessionStart auto-context hook; scaffold/map/check-links scripts. |
| **Refs** | `76970f4` docflow — living-docs + changelog-memory Claude Code plugin |

### 2. Multi-agent layer
| | |
|---|---|
| **Outcome** | Same docs system drives Codex, Gemini, and Cursor — not just Claude. |
| **Delivered** | `AGENTS.md`/`GEMINI.md`/`.cursorrules` stubs; Codex plugin support; token-light context hook. |
| **Refs** | `092389b` multi-agent layer (Codex/Gemini/Cursor) + token-light hook; `20aeb72` Codex plugin support and lean doc templates |

### 3. Navigation & output discipline
| | |
|---|---|
| **Outcome** | Agents read one compact map instead of scanning the tree; doc output kept lean. |
| **Delivered** | Auto-generated `INDEX.md` (`path → purpose`); lean-output rules (tables/bullets, tech+business, no filler); changelog template fix. |
| **Refs** | `8d5242f` INDEX.md path→purpose map; `d8a1dfc` enforce lean output; `7286cf4` drop duplicate heading in changelog template |

### 4. Scaffold hardening
| | |
|---|---|
| **Outcome** | Scaffold and session context made idempotent and safe to re-run. |
| **Delivered** | Hardened scaffold script and context wiring. |
| **Refs** | `04101c5` harden docflow scaffold and context |

### 5. Message-driven feature planning
| | |
|---|---|
| **Outcome** | Claude users can create a feature plan from a short request instead of starting from a blank template. |
| **Delivered** | `/docflow-feature-plan <msg>` command; product/spec/plan/reference docs updated. |
| **Refs** | local |

### 6. Message-driven product specs
| | |
|---|---|
| **Outcome** | Claude users can draft product WHAT docs from a brief or code path while keeping unclear product facts explicit. |
| **Delivered** | `/docflow-product-spec <msg or code path>` command; product/spec/plan/reference docs updated. |
| **Refs** | local |

### 7. Generator lint hardening
| | |
|---|---|
| **Outcome** | CI ShellCheck no longer fails on the new scan/spec generator scripts. |
| **Delivered** | Replaced fragile guard syntax, escaped literal Markdown backticks for ShellCheck, and made spec discovery tolerate empty matches under `pipefail`. |
| **Refs** | local |

### 8. Plugin version refresh
| | |
|---|---|
| **Outcome** | Claude/Codex plugin installers can detect the new command set as a newer local plugin version. |
| **Delivered** | Bumped plugin manifests from `0.2.0` to `0.2.1`. |
| **Refs** | local |

### 9. Clearer commands and docs portal
| | |
|---|---|
| **Outcome** | Users can understand each command from README/reference tables, and generated docs are easier to browse visually. |
| **Delivered** | Command docs grouped by need/output; cleaner light `index.html` portal; clearer autocomplete descriptions; plugin manifests bumped to `0.2.2`. |
| **Refs** | local |

### 10. Document validation and update logs
| | |
|---|---|
| **Outcome** | Agents can block objectively broken docs before reporting documentation work complete. |
| **Delivered** | `docflow-validate.sh`; `/docflow:docflow-validate`; `docs-validate`; doctor validation summary; helper install wiring; template update-log sections; plugin manifests bumped to `0.2.3`. |
| **Refs** | local |

### 11. Friendly readiness check
| | |
|---|---|
| **Outcome** | Users get one clear DocFlow status and exact next command instead of interpreting multiple diagnostics. |
| **Delivered** | `docflow-check.sh`; `/docflow:docflow-check`; `docs-check`; scaffold/repair helper wiring; command/reference docs; plugin manifests bumped to `0.2.4`. |
| **Refs** | local |

### 12. Marketplace readiness
| | |
|---|---|
| **Outcome** | DocFlow is prepared for `awesome-codex-plugins` scanner-gated submission requirements. |
| **Delivered** | Added HOL Plugin Scanner workflow, pinned checkout action in CI, and expanded CI to run validation/readiness tests. |
| **Refs** | local |
