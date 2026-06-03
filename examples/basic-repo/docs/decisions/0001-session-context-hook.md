# 0001 - Use a read-only session context hook

> Status: accepted
> Date: 2026-06-03
> Deciders: maintainers

## Context

AI coding sessions often start without the recent product and architecture history. Re-reading the full repository is expensive and inconsistent.

## Decision

Use a read-only session-start hook to print the docs map and newest changelog entry.

## Consequences

| Result | Impact |
|--------|--------|
| Better default context | Agents start with current docs and recent shipped work |
| Bash dependency | Users should review the hook before installing |
| Low token cost | The hook prints only compact indexes and truncated history |

## Related

- Spec: [context hook](<../specs/(jun-26)-context-hook.md>)
