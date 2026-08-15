#!/usr/bin/env bash

# The SessionStart hook truncates INDEX.md, so an alphabetical-only map hides
# whole categories in a large tree (`plans/` fits, `specs/` and `reviews/` fall
# off). The map leads with a category header instead. Validation must judge
# freshness through the generator itself, so a generator change never turns
# every map stale.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

bash "$ROOT/scripts/scaffold.sh" --target "$TMP" --docs-root docs --project "Mapped" >/dev/null

index="$TMP/docs/INDEX.md"
head -12 "$index" | grep -F '## Categories' >/dev/null || {
  echo "FAIL: category header missing from the top of the map" >&2
  exit 1
}

for category in product-spec specs decisions plans reviews changelog; do
  head -12 "$index" | grep -E "^$category/ \([0-9]+\) — start: " >/dev/null || {
    echo "FAIL: category $category absent from the header window" >&2
    head -12 "$index" >&2
    exit 1
  }
done

grep -F '## All docs' "$index" >/dev/null || { echo "FAIL: full listing missing" >&2; exit 1; }

# --stdout must match what the file-writing mode produced
bash "$ROOT/scripts/docflow-map.sh" --stdout "$TMP/docs" > "$TMP/stdout-map.md"
cmp -s "$TMP/stdout-map.md" "$index" || {
  echo "FAIL: --stdout output differs from the written INDEX.md" >&2
  exit 1
}

output="$(bash "$ROOT/scripts/docflow-validate.sh" --target "$TMP")"
printf '%s\n' "$output" | grep -F 'stale generated map' >/dev/null && {
  echo "FAIL: freshly generated map reported stale" >&2
  exit 1
}
printf '%s\n' "$output" | grep -F -- '- errors: 0' >/dev/null || {
  echo "FAIL: fresh scaffold did not validate cleanly" >&2
  printf '%s\n' "$output" >&2
  exit 1
}

echo "PASS: map category header + freshness via generator"
