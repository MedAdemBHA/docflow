#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

output="$(bash "$ROOT/scripts/docflow-doctor.sh" --target "$TMP")"

printf '%s\n' "$output" | grep -F 'Status' >/dev/null
printf '%s\n' "$output" | grep -F 'recommendation: docflow-init' >/dev/null
printf '%s\n' "$output" | grep -F -- '- /docflow-init' >/dev/null

if [ -e "$TMP/docflow.json" ] || [ -d "$TMP/docs" ]; then
  echo "FAIL: doctor mutated empty repo" >&2
  exit 1
fi

echo "PASS: doctor empty repo"
