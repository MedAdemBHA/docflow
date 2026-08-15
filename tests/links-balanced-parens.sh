#!/usr/bin/env bash

# Destinations may carry balanced parentheses — docflow's own `(mmm-yy)-topic.md`
# naming produces them on every dated doc. The checker must resolve those instead
# of truncating at the first ')' and reporting a phantom broken link.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

mkdir -p "$TMP/docs/specs"
cat > "$TMP/docs/specs/(apr-26)-topic.md" <<'EOF'
# Topic
EOF

cat > "$TMP/docs/README.md" <<'EOF'
# Docs

- [bare](specs/(apr-26)-topic.md)
- [angle](<specs/(apr-26)-topic.md>)
- [titled](specs/(apr-26)-topic.md "Topic spec")
- [fragment](specs/(apr-26)-topic.md#section)
- [external](https://example.com/a(b).md)
- inline `[code](specs/nope.md)` is ignored
- [missing](specs/(apr-26)-gone.md)
EOF

output="$(bash "$ROOT/scripts/check-links.sh" "$TMP/docs" || true)"

if printf '%s\n' "$output" | grep -F 'specs/(apr-26)-topic.md' >/dev/null; then
  echo "FAIL: resolvable link with balanced parens reported broken" >&2
  printf '%s\n' "$output" >&2
  exit 1
fi

if ! printf '%s\n' "$output" | grep -F 'specs/(apr-26)-gone.md' >/dev/null; then
  echo "FAIL: genuinely missing target was not reported" >&2
  printf '%s\n' "$output" >&2
  exit 1
fi

if [ "$(printf '%s\n' "$output" | grep -c 'BROKEN')" != "1" ]; then
  echo "FAIL: expected exactly one broken link" >&2
  printf '%s\n' "$output" >&2
  exit 1
fi

echo "PASS: links with balanced parentheses"
