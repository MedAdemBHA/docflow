#!/usr/bin/env bash
# docflow SessionStart hook.
# Injects the docs index + the newest changelog into the agent's context at
# session start, so it always knows recent history without being asked.
#
# Safe by design: read-only, output truncated, silent no-op in repos that
# don't use docflow. Never fails the session (always exits 0).

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
  for cand in docsAdem docs documentation doc .docs; do
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
echo "Docs root: $DOCS_ROOT/  (use the docs-router skill to navigate; docs-author/docs-changelog to write)"
echo

# 1) docs index (the map)
# token-light by default: this runs every session. Override via env if you want more.
# Drops blank/comment lines to cut tokens further.
IDX_LINES="${DOCFLOW_INDEX_LINES:-22}"
LOG_LINES="${DOCFLOW_LOG_LINES:-38}"
trim() { grep -vE '^\s*(<!--|$)' "$1" | head -"$2"; }

if [ -f "$DR/README.md" ]; then
  echo "--- docs index ($DOCS_ROOT/README.md, head) ---"
  trim "$DR/README.md" "$IDX_LINES"
  echo "… full map: $DOCS_ROOT/README.md"
  echo
fi

# 2) newest changelog entry (recent history)
if [ -d "$CL" ]; then
  NEWEST="$(ls -t "$CL"/*.md 2>/dev/null | grep -v -i 'README' | head -1)"
  [ -z "$NEWEST" ] && NEWEST="$(ls -t "$CL"/*.md 2>/dev/null | head -1)"
  if [ -n "$NEWEST" ] && [ -f "$NEWEST" ]; then
    echo "--- newest changelog ($(basename "$NEWEST"), head) ---"
    trim "$NEWEST" "$LOG_LINES"
    echo "… full history in $CHANGELOG_DIR"
  fi
fi

echo "=== end docflow context ==="
exit 0
