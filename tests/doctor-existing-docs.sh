#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

cat > "$TMP/README.md" <<'EOF'
# Existing Project
EOF
mkdir -p "$TMP/documentation"
cat > "$TMP/documentation/guide.md" <<'EOF'
# Guide
EOF

before="$(find "$TMP" -type f | sort | xargs cksum)"
output="$(bash "$ROOT/scripts/docflow-doctor.sh" --target "$TMP")"
after="$(find "$TMP" -type f | sort | xargs cksum)"

printf '%s\n' "$output" | grep -F 'docs root: documentation (yes)' >/dev/null
printf '%s\n' "$output" | grep -F 'recommendation: docflow-adopt' >/dev/null
printf '%s\n' "$output" | grep -F -- '- /docflow:adopt' >/dev/null

if [ "$before" != "$after" ]; then
  echo "FAIL: doctor mutated existing docs repo" >&2
  exit 1
fi

echo "PASS: doctor existing docs"
