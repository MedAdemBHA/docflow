#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

mkdir -p "$TMP/docs/product-spec"
cat > "$TMP/docflow.json" <<'JSON'
{
  "docsRoot": "docs",
  "changelogDir": "docs/changelog"
}
JSON
cat > "$TMP/docs/product-spec/00-overview.md" <<'EOF'
# Product Overview
EOF
cat > "$TMP/docs/INDEX.md" <<'EOF'
# stale
EOF

bash "$ROOT/scripts/docflow-repair.sh" --target "$TMP" >/dev/null

grep -F 'product-spec/00-overview.md — Product Overview' "$TMP/docs/INDEX.md" >/dev/null \
  || { echo "FAIL: repair did not regenerate map" >&2; exit 1; }
[ -x "$TMP/scripts/check-links.sh" ] || { echo "FAIL: repair did not install link helper" >&2; exit 1; }
[ -x "$TMP/scripts/docflow-map.sh" ] || { echo "FAIL: repair did not install map helper" >&2; exit 1; }

echo "PASS: repair generated map"
