# Upcoming — Roadmap

> Snapshot: <YYYY-MM-DD>
> Cadence: re-grade weekly. Move items between files as state changes.

Roadmap is split into four horizons, one file per horizon:

| File | Horizon | Bar for entry |
|------|---------|---------------|
| 🔥 [critical.md](critical.md) | **Critical (ASAP)** | Silent data loss, broken core UX, or blocking other work. Drop everything. |
| [now.md](now.md) | **Now** — sprint in progress | Work in flight or starting this sprint. Has an owner or about to. |
| [next.md](next.md) | **Next** — ≤ 1 sprint out | Agreed scope, not started yet. |
| [later.md](later.md) | **Later** — backlog | Not committed. Could slip a quarter without anyone caring. |

When something ships, **move the line to the right `changelog/(mmm-yy).md`** and delete it here. Don't let shipped work linger — the roadmap loses its signal.

## Rules

- An item lives in exactly one horizon. No duplicates.
- Critical items also appear in `now.md` for the sprint board — but the canonical entry is in `critical.md`.
- If critical grows beyond 4–5 items, **escalate**. Debt is accumulating faster than it's fixed.
- "Later" is the trash compactor. If nothing pulls an item up after 2 cadences, delete it.

## Recently shipped

Don't restate here. See:
- [`changelog/(mmm-yy).md`](<../../changelog/(mmm-yy).md>) — <highlights>
