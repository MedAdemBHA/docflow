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

if ! printf '%s\n' "$output" | grep -F -- '--- newest changelog ((feb-26).md, head) ---' >/dev/null; then
  printf 'FAIL: expected feb-26 to be selected by filename date\n' >&2
  printf '%s\n' "$output" >&2
  exit 1
fi

if printf '%s\n' "$output" | grep -F -- '--- newest changelog ((jan-26).md, head) ---' >/dev/null; then
  printf 'FAIL: jan-26 was selected by mtime\n' >&2
  printf '%s\n' "$output" >&2
  exit 1
fi

echo "PASS: changelog ordering uses filename date"
