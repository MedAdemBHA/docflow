#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

mkdir -p "$TMP/documentation"
cat > "$TMP/README.md" <<'EOF'
# Existing Project
EOF
cat > "$TMP/documentation/guide.md" <<'EOF'
# Guide

Existing content must stay.
EOF
before="$(cksum "$TMP/documentation/guide.md")"

bash "$ROOT/scripts/docflow-adopt.sh" --target "$TMP" --docs-root documentation --project "Existing Project" >/dev/null

after="$(cksum "$TMP/documentation/guide.md")"
[ "$before" = "$after" ] || { echo "FAIL: adopt rewrote existing doc" >&2; exit 1; }

[ -f "$TMP/docflow.json" ] || { echo "FAIL: docflow.json missing" >&2; exit 1; }
[ -f "$TMP/AGENTS.md" ] || { echo "FAIL: AGENTS.md missing" >&2; exit 1; }
[ -f "$TMP/documentation/INDEX.md" ] || { echo "FAIL: INDEX.md missing" >&2; exit 1; }
[ -f "$TMP/scripts/check-links.sh" ] || { echo "FAIL: check-links helper missing" >&2; exit 1; }
[ -f "$TMP/scripts/docflow-doctor.sh" ] || { echo "FAIL: doctor helper missing" >&2; exit 1; }

find "$TMP/documentation/reviews" -name '(*)-docs-adoption.md' | grep . >/dev/null \
  || { echo "FAIL: adoption review missing" >&2; exit 1; }

echo "PASS: adopt existing docs"
