#!/usr/bin/env bash
# docflow scaffold — drop the 7-category doc tree into a repo.
#
# Usage:
#   scripts/scaffold.sh [--docs-root docs] [--project "My App"] [--target .]
#
# Idempotent: never overwrites an existing file. Re-runnable safely.

set -euo pipefail

DOCS_ROOT="docs"
PROJECT="<PROJECT>"
TARGET="$PWD"

while [ $# -gt 0 ]; do
  case "$1" in
    --docs-root) DOCS_ROOT="$2"; shift 2 ;;
    --project)   PROJECT="$2";   shift 2 ;;
    --target)    TARGET="$2";    shift 2 ;;
    -h|--help)
      grep '^#' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown arg: $1" >&2; exit 1 ;;
  esac
done

# template dirs = sibling of this script's parent
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TPL="$SCRIPT_DIR/../templates"
REPO_TPL="$SCRIPT_DIR/../repo-templates"
[ -d "$TPL" ] || { echo "templates not found at $TPL" >&2; exit 1; }
[ -d "$REPO_TPL" ] || { echo "repo templates not found at $REPO_TPL" >&2; exit 1; }

DEST="$TARGET/$DOCS_ROOT"
echo "docflow: scaffolding into $DEST/ (project: $PROJECT)"

# copy the template tree, skipping any file that already exists
mkdir -p "$DEST"
copied=0; skipped=0
while IFS= read -r src; do
  rel="${src#"$TPL"/}"
  out="$DEST/$rel"
  mkdir -p "$(dirname "$out")"
  if [ -e "$out" ]; then
    skipped=$((skipped+1))
  else
    cp "$src" "$out"
    copied=$((copied+1))
  fi
done < <(find "$TPL" -type f)

# copy repo-root agent guidance, also skipping any file that already exists
while IFS= read -r src; do
  rel="${src#"$REPO_TPL"/}"
  out="$TARGET/$rel"
  mkdir -p "$(dirname "$out")"
  if [ -e "$out" ]; then
    skipped=$((skipped+1))
  else
    cp "$src" "$out"
    copied=$((copied+1))
  fi
done < <(find "$REPO_TPL" -type f)

# fill placeholders in newly scaffolded files only
if [ -f "$DEST/README.md" ] && grep -q '<PROJECT>' "$DEST/README.md" 2>/dev/null; then
  sed -i.bak "s/<PROJECT>/$PROJECT/g" "$DEST/README.md" && rm -f "$DEST/README.md.bak"
fi
for file in "$TARGET/AGENTS.md" "$TARGET/GEMINI.md" "$TARGET/.cursorrules"; do
  if [ -f "$file" ] && grep -q '<DOCS_ROOT>\|<PROJECT>' "$file" 2>/dev/null; then
    sed -i.bak \
      -e "s|<DOCS_ROOT>|$DOCS_ROOT|g" \
      -e "s|<PROJECT>|$PROJECT|g" \
      "$file" && rm -f "$file.bak"
  fi
done

# write per-repo config at the target root if absent
CFG="$TARGET/docflow.json"
if [ ! -f "$CFG" ]; then
  cat > "$CFG" <<EOF
{
  "docsRoot": "$DOCS_ROOT",
  "changelogDir": "$DOCS_ROOT/changelog"
}
EOF
  echo "docflow: wrote $CFG"
fi

# generate the compact map (token-light tree the agent reads first)
bash "$SCRIPT_DIR/docflow-map.sh" "$DEST" || true

echo "docflow: done — $copied file(s) created, $skipped already existed."
echo "Next: fill $DOCS_ROOT/README.md, add a 'Documentation' link in your root README,"
echo "confirm AGENTS.md points at the right docs root, and start the first changelog month."
