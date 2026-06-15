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

# Empty repo should have one obvious setup path.
empty="$TMP/empty"
mkdir -p "$empty"
set +e
empty_output="$(bash "$ROOT/scripts/docflow-check.sh" --target "$empty")"
empty_status="$?"
set -e
[ "$empty_status" -ne 0 ] || fail "empty repo check should not be ready"
assert_contains "$empty_output" "- status: Needs setup"
assert_contains "$empty_output" "- next: /docflow:init"

# Existing docs without docflow config should route to adoption.
legacy="$TMP/legacy"
mkdir -p "$legacy/docs"
cat > "$legacy/README.md" <<'EOF'
# Legacy
EOF
cat > "$legacy/docs/guide.md" <<'EOF'
# Guide
EOF
set +e
legacy_output="$(bash "$ROOT/scripts/docflow-check.sh" --target "$legacy")"
legacy_status="$?"
set -e
[ "$legacy_status" -ne 0 ] || fail "legacy repo check should not be ready"
assert_contains "$legacy_output" "- status: Needs adoption"
assert_contains "$legacy_output" "- next: /docflow:adopt"

# Fresh scaffold should be ready even with template warnings.
ready="$TMP/ready"
mkdir -p "$ready"
bash "$ROOT/scripts/scaffold.sh" --target "$ready" --docs-root docs --project "Ready Project" >/dev/null
ready_output="$(bash "$ROOT/scripts/docflow-check.sh" --target "$ready")"
assert_contains "$ready_output" "- status: Ready"
assert_contains "$ready_output" "- next: No action needed."

# Missing helper in a docflow repo should route to repair.
repair="$TMP/repair"
cp -R "$ready" "$repair"
rm -f "$repair/scripts/docflow-validate.sh"
set +e
repair_output="$(bash "$ROOT/scripts/docflow-check.sh" --target "$repair")"
repair_status="$?"
set -e
[ "$repair_status" -ne 0 ] || fail "repair repo check should not be ready"
assert_contains "$repair_output" "- status: Needs repair"
assert_contains "$repair_output" "- next: /docflow:repair"

# Validation errors should be blocked and point to validate.
blocked="$TMP/blocked"
cp -R "$ready" "$blocked"
cat > "$blocked/docs/product-spec/01-bad.md" <<'EOF'
No H1.
EOF
set +e
blocked_output="$(bash "$ROOT/scripts/docflow-check.sh" --target "$blocked")"
blocked_status="$?"
set -e
[ "$blocked_status" -ne 0 ] || fail "blocked repo check should not be ready"
assert_contains "$blocked_output" "- status: Blocked"
assert_contains "$blocked_output" "- next: /docflow:validate"
assert_contains "$blocked_output" "Top validation errors"

echo "PASS: check readiness"
