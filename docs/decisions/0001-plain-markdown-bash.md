# 0001 — Plain Markdown and Bash as the portable core

> **Status:** Accepted
> **Date:** 2026-06-03
> **Deciders:** Maintainer

## Context

DocFlow must work inside many repositories and across Claude, Codex, Gemini, and Cursor. A server, database, or heavy runtime would make setup harder and reduce trust for a plugin that runs in developer workspaces.

## Decision

Keep DocFlow's durable state as Markdown files and `docflow.json`, with Bash/coreutils scripts as the shared implementation layer.

## Consequences

**Good**
- Easy to inspect before installing.
- Works with plain GitHub rendering.
- Agent-specific wrappers can stay thin.
- CI can validate scripts without provisioning services.

**Bad**
- Windows-native support is not first-class yet.
- Bash parsing needs defensive tests.
- Rich UI workflows are out of scope.

## Alternatives Considered

- **Node CLI** — better cross-platform packaging, but adds runtime/package-manager dependency.
- **Python CLI** — readable and portable, but still adds a runtime expectation to every target repo.
- **Hosted docs service** — richer UX, but changes DocFlow from repo-native memory into a SaaS.
