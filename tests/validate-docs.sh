#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

assert_contains() {
  haystack="$1"
  needle="$2"
  printf '%s\n' "$haystack" | grep -F -- "$needle" >/dev/null \
    || fail "expected output to contain: $needle"
}

# Fresh scaffolds intentionally contain template placeholders, but they should
# validate with warnings rather than blocking errors.
fresh="$TMP/fresh"
mkdir -p "$fresh"
bash "$ROOT/scripts/scaffold.sh" --target "$fresh" --docs-root docs --project "Fresh Project" >/dev/null

[ -x "$fresh/scripts/docflow-validate.sh" ] || fail "validate helper was not scaffolded"
fresh_output="$(bash "$ROOT/scripts/docflow-validate.sh" --target "$fresh")"
assert_contains "$fresh_output" "- errors: 0"
assert_contains "$fresh_output" "unfilled template placeholders remain"

# Broken docs should fail with objective blockers.
broken="$TMP/broken"
mkdir -p "$broken/docs/product-spec" "$broken/docs/specs" "$broken/docs/changelog"
cat > "$broken/docflow.json" <<'JSON'
{
  "docsRoot": "docs",
  "changelogDir": "docs/changelog",
  "validationProfile": "strict"
}
JSON
cat > "$broken/docs/README.md" <<'EOF'
# Broken Docs

[Missing](missing.md)
EOF
cat > "$broken/docs/INDEX.md" <<'EOF'
# stale
EOF
cat > "$broken/docs/product-spec/01-real.md" <<'EOF'
# Real Module

## Purpose
<topic>
EOF
cat > "$broken/docs/specs/(jun-26)-bad.md" <<'EOF'
No H1 here.
EOF
cat > "$broken/docs/changelog/june.md" <<'EOF'
# Bad Month
EOF

set +e
broken_output="$(bash "$ROOT/scripts/docflow-validate.sh" --target "$broken" 2>&1)"
broken_status="$?"
set -e
[ "$broken_status" -ne 0 ] || fail "broken docs validation passed"
assert_contains "$broken_output" "stale generated map"
assert_contains "$broken_output" "BROKEN:"
assert_contains "$broken_output" "placeholder tokens remain"
assert_contains "$broken_output" "missing first-level H1"
assert_contains "$broken_output" "unsupported docflow category path"

# Adopted legacy docs outside the taxonomy are warnings, not blockers.
legacy="$TMP/legacy"
mkdir -p "$legacy/documentation"
cat > "$legacy/README.md" <<'EOF'
# Legacy Project
EOF
cat > "$legacy/documentation/guide.md" <<'EOF'
# Existing Guide

Keep this legacy doc.
EOF
bash "$ROOT/scripts/docflow-adopt.sh" --target "$legacy" --docs-root documentation --project "Legacy Project" >/dev/null
legacy_output="$(bash "$ROOT/scripts/docflow-validate.sh" --target "$legacy")"
assert_contains "$legacy_output" "- errors: 0"
assert_contains "$legacy_output" "preserved as an adopted documentation root"

# Adopted repositories may retain numbered specs, category indexes, custom
# roots, and their own section vocabulary. Code examples that use angle-bracket
# notation are not placeholder leakage.
adopted="$TMP/adopted-shape"
mkdir -p "$adopted/docs/product-spec" "$adopted/docs/specs" "$adopted/docs/devops"
cat > "$adopted/README.md" <<'EOF'
# Established Project
EOF
cat > "$adopted/docs/product-spec/README.md" <<'EOF'
# Product index
EOF
cat > "$adopted/docs/product-spec/01-requirements.md" <<'EOF'
# Requirements

## Capabilities

Established section vocabulary.
EOF
cat > "$adopted/docs/specs/00-master-plan.md" <<'EOF'
# Master plan

Use `<status>` in an inline code example.

```text
<module>
```
EOF
cat > "$adopted/docs/devops/01-environments.md" <<'EOF'
# Environments
EOF
bash "$ROOT/scripts/docflow-adopt.sh" --target "$adopted" --docs-root docs --project "Established Project" >/dev/null
adopted_output="$(bash "$ROOT/scripts/docflow-validate.sh" --target "$adopted")"
assert_contains "$adopted_output" "- validation profile: adopted"
assert_contains "$adopted_output" "- errors: 0"
assert_contains "$adopted_output" "specs/: adopted paths differ from native DocFlow naming"
if printf '%s\n' "$adopted_output" | grep -F 'possible placeholder tokens remain' >/dev/null; then
  fail "code examples were reported as placeholders"
fi

cat >> "$adopted/docs/devops/01-environments.md" <<'EOF'

[Broken](missing.md)
EOF
bash "$ROOT/scripts/docflow-map.sh" "$adopted/docs" >/dev/null
set +e
adopted_broken="$(bash "$ROOT/scripts/docflow-validate.sh" --target "$adopted" 2>&1)"
adopted_broken_status="$?"
set -e
[ "$adopted_broken_status" -ne 0 ] || fail "adopted profile allowed a broken link"
assert_contains "$adopted_broken" "BROKEN:"

before="$(find "$legacy" -type f | sort | xargs cksum)"
doctor_output="$(bash "$ROOT/scripts/docflow-doctor.sh" --target "$legacy")"
after="$(find "$legacy" -type f | sort | xargs cksum)"
[ "$before" = "$after" ] || fail "doctor mutated repo while summarizing validation"
assert_contains "$doctor_output" "- validation: pass"

echo "PASS: validate docs"
