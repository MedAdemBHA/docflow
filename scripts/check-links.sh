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

  while IFS= read -r target; do
    # drop an optional link title:  path "Title"  /  path 'Title'
    case "$target" in
      *' "'*) target="${target%% \"*}" ;;
      *" '"*) target="${target%% \'*}" ;;
    esac
    target="${target%%#*}"
    # trim surrounding whitespace
    target="${target#"${target%%[![:space:]]*}"}"
    target="${target%"${target##*[![:space:]]}"}"

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
    # Emit one link destination per line.
    #
    # CommonMark allows unescaped parentheses inside a destination as long as
    # they are balanced, so `[x](specs/(apr-26)-topic.md)` is a valid link that
    # a naive `\]\([^)]+\)` match would truncate at `specs/(apr-26`. This walks
    # the line and tracks nesting depth instead, and also understands the
    # angle-bracket form `[x](<dest with spaces>)`.
    awk '
      /^[[:space:]]*(```|~~~)/ { in_fence = !in_fence; next }
      in_fence { next }
      {
        line = $0
        gsub(/`[^`]*`/, "", line)
        n = length(line)
        i = 1
        while (i < n) {
          if (substr(line, i, 2) != "](") { i++; continue }
          j = i + 2
          if (substr(line, j, 1) == "<") {
            rest = substr(line, j + 1)
            k = index(rest, ">")
            if (k > 0) {
              print substr(rest, 1, k - 1)
              i = j + k + 1
              continue
            }
          }
          depth = 1
          dest = ""
          while (j <= n) {
            c = substr(line, j, 1)
            if (c == "(") depth++
            else if (c == ")") { depth--; if (depth == 0) break }
            dest = dest c
            j++
          }
          if (depth == 0 && dest != "") print dest
          i = j + 1
        }
      }
    ' "$file" 2>/dev/null || true
  )
done < <(find "$ROOT" -type f -name '*.md' -print0)

exit "$broken"
