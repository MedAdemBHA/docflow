#!/usr/bin/env bash

# Adoption must not drop rename-me skeletons into categories that already hold
# real docs: they are noise in a mature tree, and `decisions/0001-title.md`
# would duplicate an existing ADR number. Empty categories still get seeded, so
# a fresh scaffold keeps every skeleton.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

mkdir -p "$TMP/docs/decisions" "$TMP/docs/specs" "$TMP/docs/changelog" "$TMP/docs/product-spec"
echo '# 0001 — URL as state' > "$TMP/docs/decisions/0001-url-as-state.md"
echo '# Tab system' > "$TMP/docs/specs/(apr-26)-tab-system.md"
echo '# August 2026' > "$TMP/docs/changelog/(aug-26).md"
echo '# Overview' > "$TMP/docs/product-spec/00-overview.md"

bash "$ROOT/scripts/docflow-adopt.sh" --target "$TMP" --docs-root docs --project "Fixture" >/dev/null

for unwanted in \
  "$TMP/docs/decisions/0001-title.md" \
  "$TMP/docs/specs/(mmm-yy)-topic.md" \
  "$TMP/docs/changelog/(mmm-yy).md" \
  "$TMP/docs/product-spec/NN-topic.md"
do
  if [ -e "$unwanted" ]; then
    echo "FAIL: skeleton seeded into a populated category: $unwanted" >&2
    exit 1
  fi
done

# real seed content still lands
[ -f "$TMP/docs/decisions/README.md" ] || { echo "FAIL: category README missing" >&2; exit 1; }
# untouched existing docs
[ -f "$TMP/docs/decisions/0001-url-as-state.md" ] || { echo "FAIL: existing ADR removed" >&2; exit 1; }
# empty category still seeded
[ -f "$TMP/docs/plans/features/(mmm-yy)-feature-name.md" ] || {
  echo "FAIL: empty category lost its skeleton" >&2
  exit 1
}

# and a fresh scaffold keeps every skeleton
FRESH="$(mktemp -d)"
trap 'rm -rf "$TMP" "$FRESH"' EXIT
bash "$ROOT/scripts/scaffold.sh" --target "$FRESH" --docs-root docs --project "Fresh" >/dev/null
for wanted in \
  "$FRESH/docs/decisions/0001-title.md" \
  "$FRESH/docs/specs/(mmm-yy)-topic.md" \
  "$FRESH/docs/changelog/(mmm-yy).md" \
  "$FRESH/docs/product-spec/NN-topic.md"
do
  [ -f "$wanted" ] || { echo "FAIL: fresh scaffold missing $wanted" >&2; exit 1; }
done

echo "PASS: adopt skips skeletons in populated categories"
