#!/usr/bin/env bash

# A docs tree is recognized by its shape, not only by the folder names docflow
# happens to scaffold. A repo whose knowledge base lives in `docsAdem/` or
# `knowledge/` must be found — and when a second tree exists with no config to
# disambiguate, doctor must say so instead of silently picking one.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

mkdir -p "$TMP/knowledge/changelog" "$TMP/knowledge/specs" "$TMP/knowledge/decisions"
echo '# August 2026' > "$TMP/knowledge/changelog/(aug-26).md"
echo '# Spec' > "$TMP/knowledge/specs/thing.md"
echo '# 0001 — Choice' > "$TMP/knowledge/decisions/0001-choice.md"

# a stray folder named docs/ that is NOT a docs tree must not win
mkdir -p "$TMP/docs"
echo '# stray' > "$TMP/docs/notes.md"

before="$(find "$TMP" -type f | sort | xargs cksum)"
output="$(bash "$ROOT/scripts/docflow-doctor.sh" --target "$TMP")"
after="$(find "$TMP" -type f | sort | xargs cksum)"

printf '%s\n' "$output" | grep -F 'docs root: knowledge (yes)' >/dev/null || {
  echo "FAIL: non-standard docs root not discovered" >&2
  printf '%s\n' "$output" >&2
  exit 1
}

if printf '%s\n' "$output" | grep -F 'ambiguous docs root' >/dev/null; then
  echo "FAIL: warned about ambiguity with only one real docs tree" >&2
  exit 1
fi

# now make docs/ a real second tree — ambiguity must be reported
mkdir -p "$TMP/docs/specs" "$TMP/docs/plans"
echo '# legacy' > "$TMP/docs/specs/legacy.md"
second="$(bash "$ROOT/scripts/docflow-doctor.sh" --target "$TMP")"
printf '%s\n' "$second" | grep -F 'ambiguous docs root' >/dev/null || {
  echo "FAIL: two docs trees and no config did not raise ambiguity" >&2
  printf '%s\n' "$second" >&2
  exit 1
}

# an explicit config silences it
cat > "$TMP/docflow.json" <<'EOF'
{
  "docsRoot": "knowledge",
  "changelogDir": "knowledge/changelog",
  "validationProfile": "adopted"
}
EOF
third="$(bash "$ROOT/scripts/docflow-doctor.sh" --target "$TMP")"
if printf '%s\n' "$third" | grep -F 'ambiguous docs root' >/dev/null; then
  echo "FAIL: configured docsRoot still reported as ambiguous" >&2
  exit 1
fi

if [ "$before" != "$after" ]; then
  echo "FAIL: doctor mutated the repo" >&2
  exit 1
fi

echo "PASS: doctor discovers non-standard docs roots"
