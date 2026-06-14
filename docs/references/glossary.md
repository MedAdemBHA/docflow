<!-- docflow: reference. Shared terminology for DocFlow docs and agent UX. -->
# Glossary

| Term | Meaning |
|------|---------|
| Doctor | Read-only scan that recommends init, adopt, or repair |
| Init | Create a fresh docflow docs tree for repos without meaningful docs |
| Adopt | Add docflow infrastructure around existing docs without overwriting them |
| Repair | Regenerate generated docs map, reinstall helpers, and report links/placeholders |
| Validate | Read-only readiness gate that blocks broken docs via non-zero exit |
| Docs root | Directory configured by `docflow.json` as the project documentation root |
| Metadata comment | Lightweight `<!-- docflow: ... -->` marker describing a doc's role |
| Update log | Per-document table recording date, change, and source/reference |
| Changelog memory | Monthly append-only shipped-work record surfaced to agents |
| Agent guidance | Root files such as `AGENTS.md`, `GEMINI.md`, and `.cursorrules` |
| Docs map | Generated `INDEX.md` with one `path — purpose` line per Markdown file |
