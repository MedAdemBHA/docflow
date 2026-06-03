# DocFlow — Product Specification Overview

> **App Name:** DocFlow
> **Type:** AI-agent documentation workflow plugin and repo scaffold
> **Stack:** Bash, Markdown, Claude Code plugin manifest, Codex plugin manifest

## What Is DocFlow?

DocFlow gives a software repository a structured, low-token documentation memory so AI coding agents and humans can find product behavior, implementation details, decisions, plans, reviews, and shipped changes without rediscovering project context every session.

## Users

| User | Need | DocFlow value |
|------|------|---------------|
| Solo developer | Keep project context across long AI sessions | Session hook and changelog surface recent work automatically |
| AI coding agent | Know where to read before editing code | `AGENTS.md`, `docs/INDEX.md`, and routing skills point to exact docs |
| Maintainer/team | Preserve decisions and shipped history | ADRs, specs, plans, reviews, and changelog stay versioned with code |

## Core Modules

| # | Module | What it does |
|---|--------|--------------|
| 1 | Doctor | Read-only scan that recommends init, adopt, or repair based on repo state |
| 2 | Init | Scaffolds the 7-category docs tree only when the repo has no meaningful docs |
| 3 | Adopt | Adds docflow infrastructure to repos that already have docs without overwriting content |
| 4 | Repair | Regenerates `INDEX.md`, installs missing helpers, checks links, and reports placeholders |
| 5 | Context hook | Reads `docflow.json`, prints the docs map and newest valid changelog month, exits safely |
| 6 | Agent skills/commands | Exposes the workflow to Claude and Codex while Gemini/Cursor use repo guidance files |
| 7 | Feature plan command | Turns a short feature request into a dated feature plan with status, log, next steps, and doc follow-ups |
| 8 | Product spec command | Turns a feature brief or code path into product WHAT docs without guessing unclear behavior |

## Success Criteria

| Area | Requirement |
|------|-------------|
| Safety | Doctor is read-only; hook never fails sessions; adopt/repair never rewrite content docs |
| Portability | Works with Bash/coreutils and Markdown; no jq, DB, server, or SaaS dependency |
| Discoverability | One generated `docs/INDEX.md` maps paths to purpose |
| Maintenance | Tests cover scaffold idempotency, changelog ordering, doctor, adopt, and repair |

## Non-Goals

- Document approval, e-signature, or workflow analytics SaaS.
- Automatic aggressive cleanup or moving existing docs.
- Windows/PowerShell implementation in the current phase.
