#!/usr/bin/env bash
# docflow SessionStart hook.
# Injects the docs index + the newest changelog into the agent's context at
# session start, so it always knows recent history without being asked.
#
# Safe by design: read-only, output truncated, silent no-op when no configured
# or discoverable docs root exists. Never fails the session (always exits 0).

set -u

# --- locate the project root -------------------------------------------------
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$PWD}"
cd "$PROJECT_DIR" 2>/dev/null || exit 0

# --- read config (docflow.json) without requiring jq -------------------------
# Keys: docsRoot (dir holding the docs tree), changelogDir (defaults docsRoot/changelog)
DOCS_ROOT=""
CHANGELOG_DIR=""
CFG="$PROJECT_DIR/docflow.json"
json_val() {
  # $1 = key ; reads $CFG ; prints first string value or empty
  grep -oE "\"$1\"[[:space:]]*:[[:space:]]*\"[^\"]*\"" "$CFG" 2>/dev/null \
    | head -1 | sed -E "s/.*:[[:space:]]*\"([^\"]*)\".*/\1/"
}
if [ -f "$CFG" ]; then
  DOCS_ROOT="$(json_val docsRoot)"
  CHANGELOG_DIR="$(json_val changelogDir)"
fi

# --- fall back to discovery if no config -------------------------------------
if [ -z "$DOCS_ROOT" ]; then
  for cand in docs documentation doc .docs; do
    if [ -d "$PROJECT_DIR/$cand" ] && [ -d "$PROJECT_DIR/$cand/changelog" ]; then
      DOCS_ROOT="$cand"
      break
    fi
  done
fi

# nothing to do — stay silent
[ -z "$DOCS_ROOT" ] && exit 0

# resolve to absolute, allow docsRoot given as absolute or relative
case "$DOCS_ROOT" in
  /*) DR="$DOCS_ROOT" ;;
  *)  DR="$PROJECT_DIR/$DOCS_ROOT" ;;
esac
[ -d "$DR" ] || exit 0

[ -z "$CHANGELOG_DIR" ] && CHANGELOG_DIR="$DR/changelog"
case "$CHANGELOG_DIR" in
  /*) CL="$CHANGELOG_DIR" ;;
  *)  CL="$PROJECT_DIR/$CHANGELOG_DIR" ;;
esac

# --- emit context ------------------------------------------------------------
echo "=== docflow: project documentation context ==="
echo "Docs root: $DOCS_ROOT/  (skills: router = find a doc, author = write one, changelog = record shipped work)"
echo

# 1) docs index (the map)
# token-light by default: this runs every session. Override via env if you want more.
# Drops blank/comment lines to cut tokens further.
line_count_or_default() {
  value="$1"
  fallback="$2"
  case "$value" in
    ''|*[!0-9]*) printf '%s' "$fallback" ;;
    *) [ "$value" -gt 0 ] && printf '%s' "$value" || printf '%s' "$fallback" ;;
  esac
}
IDX_LINES="$(line_count_or_default "${DOCFLOW_INDEX_LINES:-}" 30)"
LOG_LINES="$(line_count_or_default "${DOCFLOW_LOG_LINES:-}" 20)"
trim() { grep -vE '^[[:space:]]*(<!--|$)' "$1" | head -"$2"; }
changelog_excerpt() {
  awk -v max="$2" '
    function emit(line) {
      if (count >= max || line ~ /^[[:space:]]*(<!--|$)/) return
      print line
      count++
    }
    /^##[[:space:]]+/ {
      title = tolower($0)
      keep = 0
      if (title ~ /^##[[:space:]]+summary([[:space:]]|$)/) {
        keep = 1
      } else if (title !~ /^##[[:space:]]+(table of contents|what changed|update log)([[:space:]]|$)/ && !have_latest) {
        keep = 1
        have_latest = 1
      }
      if (keep) emit($0)
      seen_section = 1
      next
    }
    !seen_section || keep { emit($0) }
  ' "$1"
}
month_num() {
  case "$1" in
    jan) printf '01' ;;
    feb) printf '02' ;;
    mar) printf '03' ;;
    apr) printf '04' ;;
    may) printf '05' ;;
    jun) printf '06' ;;
    jul) printf '07' ;;
    aug) printf '08' ;;
    sep) printf '09' ;;
    oct) printf '10' ;;
    nov) printf '11' ;;
    dec) printf '12' ;;
    *) return 1 ;;
  esac
}

# prefer the compact map (path — purpose); it's the whole tree at lowest token cost
if [ -f "$DR/INDEX.md" ]; then
  echo "--- docs map ($DOCS_ROOT/INDEX.md) — open the exact doc you need ---"
  trim "$DR/INDEX.md" "$IDX_LINES"
  echo "… $DOCS_ROOT/INDEX.md"
  echo
elif [ -f "$DR/README.md" ]; then
  echo "--- docs index ($DOCS_ROOT/README.md, head) ---"
  trim "$DR/README.md" "$IDX_LINES"
  echo "… full map: $DOCS_ROOT/README.md"
  echo
fi

# 2) newest changelog entry (recent history)
if [ -d "$CL" ]; then
  NEWEST=""
  NEWEST_KEY=""
  for candidate in "$CL"/*.md; do
    [ -f "$candidate" ] || continue
    base="$(basename "$candidate")"
    case "$base" in
      \(???-[0-9][0-9]\).md) ;;
      *) continue ;;
    esac

    month="${base:1:3}"
    yy="${base:5:2}"
    mm="$(month_num "$month")" || continue
    key="$yy-$mm"

    if [ -z "$NEWEST_KEY" ] || [[ "$key" > "$NEWEST_KEY" ]]; then
      NEWEST_KEY="$key"
      NEWEST="$candidate"
    fi
  done

  if [ -n "$NEWEST" ] && [ -f "$NEWEST" ]; then
    echo "--- newest changelog ($(basename "$NEWEST"), summary + latest entry) ---"
    changelog_excerpt "$NEWEST" "$LOG_LINES"
    echo "… full history in $CHANGELOG_DIR"
  fi
fi

echo "=== end docflow context ==="
exit 0
