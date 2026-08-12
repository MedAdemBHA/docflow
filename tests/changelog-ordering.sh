#!/usr/bin/env bash
# Regression: newest changelog must be selected by filename date, not mtime.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

mkdir -p "$TMP/docs/changelog"

cat > "$TMP/docflow.json" <<'JSON'
{
  "docsRoot": "docs",
  "changelogDir": "docs/changelog"
}
JSON

cat > "$TMP/docs/changelog/(jan-26).md" <<'EOF'
# January 2026 - Old Month

January content.
EOF

cat > "$TMP/docs/changelog/(feb-26).md" <<'EOF'
# February 2026 - New Month

February content.
EOF

cat > "$TMP/docs/changelog/README.md" <<'EOF'
# Changelog
EOF

cat > "$TMP/docs/changelog/(mmm-yy).md" <<'EOF'
# <Month YEAR> - <release / period title>
EOF

touch -t 202602010000 "$TMP/docs/changelog/(feb-26).md"
touch -t 202603010000 "$TMP/docs/changelog/(jan-26).md"

output="$(CLAUDE_PROJECT_DIR="$TMP" bash "$ROOT/hooks/docflow-context.sh")"

if ! printf '%s\n' "$output" | grep -F -- '--- newest changelog ((feb-26).md, summary + latest entry) ---' >/dev/null; then
  printf 'FAIL: expected feb-26 to be selected by filename date\n' >&2
  printf '%s\n' "$output" >&2
  exit 1
fi

if printf '%s\n' "$output" | grep -F -- '--- newest changelog ((jan-26).md, summary + latest entry) ---' >/dev/null; then
  printf 'FAIL: jan-26 was selected by mtime\n' >&2
  printf '%s\n' "$output" >&2
  exit 1
fi

cat > "$TMP/docs/changelog/(mar-26).md" <<'EOF'
# March 2026 - Structured Month

> Status: active

## Table of contents

- Summary
- Latest

## Summary

- Important summary.

## Latest delivery — Mar 4

Latest outcome.

## Older delivery — Mar 1

This older entry should not be loaded.
EOF

structured="$(CLAUDE_PROJECT_DIR="$TMP" bash "$ROOT/hooks/docflow-context.sh")"
printf '%s\n' "$structured" | grep -F -- 'Important summary.' >/dev/null \
  || { echo "FAIL: structured changelog summary missing" >&2; exit 1; }
printf '%s\n' "$structured" | grep -F -- 'Latest outcome.' >/dev/null \
  || { echo "FAIL: structured changelog latest entry missing" >&2; exit 1; }
if printf '%s\n' "$structured" | grep -F -- 'This older entry should not be loaded.' >/dev/null; then
  echo "FAIL: structured changelog loaded older history" >&2
  exit 1
fi

echo "PASS: changelog ordering uses filename date"
