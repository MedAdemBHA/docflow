# Contributing

docflow is an early developer tool. Keep changes small, testable, and explicit about agent safety.

## Local Checks

Run these before opening a pull request:

```bash
bash scripts/test-scaffold.sh
shellcheck scripts/*.sh hooks/*.sh
```

If `shellcheck` is not installed, install it with your system package manager. The GitHub Actions workflow runs it on every push and pull request.

## What To Improve

Useful contribution areas:

- scaffold portability and idempotency
- safer plugin and hook behavior
- clearer install docs for Claude Code and Codex
- better templates and examples
- CI checks for generated docs and links

## Pull Request Checklist

- The scaffold does not overwrite or mutate existing project files.
- New shell code passes `shellcheck`.
- Placeholder values with spaces, `/`, `&`, and quotes still work.
- Any new docs are linked from `README.md` or `examples/`.
- Security-sensitive behavior is documented in `SECURITY.md`.

## Release Notes

User-visible changes should be added to `CHANGELOG.md` under `Unreleased`.
