#!/usr/bin/env bash
# Check relative markdown links under a docs root.
#
# Usage:
#   scripts/check-links.sh [docs-root]
#
# Empty output means all local markdown links resolve.

set -euo pipefail

ROOT="${1:-docs}"
[ -d "$ROOT" ] || { echo "no docs root: $ROOT" >&2; exit 1; }

broken=0

while IFS= read -r -d '' file; do
  dir="$(dirname "$file")"

  while IFS= read -r link; do
    target="${link#](}"
    target="${target%)}"
    target="${target#<}"
    target="${target%>}"
    target="${target%%#*}"

    case "$target" in
      ''|'#'*|/*|http://*|https://*|mailto:*|tel:*)
        continue
        ;;
    esac

    case "$target" in
      *'<'*|*'>'*|*'(mmm-yy'*|*'NNNN-'*|*'NN-'*|'...'|path/*)
        continue
        ;;
    esac

    if [ -f "$dir/$target" ] || [ -d "$dir/$target" ]; then
      continue
    fi

    printf 'BROKEN: %s -> %s\n' "$file" "$target"
    broken=1
  done < <(
    awk '
      /^[[:space:]]*(```|~~~)/ { in_fence = !in_fence; next }
      !in_fence {
        line = $0
        gsub(/`[^`]*`/, "", line)
        print line
      }
    ' "$file" 2>/dev/null \
      | grep -oE '\]\(<[^>]+>\)|\]\([^)]+\)' || true
  )
done < <(find "$ROOT" -type f -name '*.md' -print0)

exit "$broken"
