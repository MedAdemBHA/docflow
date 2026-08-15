# DocFlow Social Captions

Choose the image that matches the discussion:

- [`docflow-context-optimization-v2.png`](docflow-context-optimization-v2.png) is the recommended clean social card: one metric, one route-first flow, three benefits, and one caveat.
- [`docflow-feature-overview.png`](docflow-feature-overview.png) explains the complete product workflow: diagnose, organize, load less, validate, and inspect generated repository outputs.
- [`docflow-context-optimization.png`](docflow-context-optimization.png) explains route-first loading, its practical benefits, the two measured results, and the limits of the token-saving claim.

Repository: https://github.com/MedAdemBHA/docflow

## X

Your AI coding agent should not rediscover the project in every session.

I built DocFlow: plain-Markdown project memory organized around WHAT, HOW, WHY, and what SHIPPED—plus a compact route map so agents open the right doc instead of the whole library.

Open source: https://github.com/MedAdemBHA/docflow

#OpenSource #AICoding #DevTools

### X — context optimization angle

DocFlow does not compress Markdown or promise 99% fewer tokens for every task.

It reduces startup context by loading a 30-line docs map + 20 lines of recent history, then opening the exact task document only when needed.

Measured initial docs context avoided: 99.53% and 99.63% (word-count proxy).

https://github.com/MedAdemBHA/docflow

## LinkedIn

AI coding agents are capable, but every new session can begin with the same expensive questions: What does this product do? How is it built? Why was this decision made? What changed recently?

I built **DocFlow** to give agents durable project memory using plain Markdown.

It adds a clear home for:

- **WHAT** — product behavior
- **HOW** — technical specifications
- **WHY** — architecture decisions
- **SHIPPED** — append-only monthly changelogs

Instead of loading an entire documentation library, the agent starts with a compact `path → purpose` map and opens the relevant document for the task. DocFlow can initialize a new documentation system or adopt an existing one without rewriting user-authored docs.

It works today with Claude Code and through repository guidance for Codex, Gemini, Cursor, and other repo-aware agents.

DocFlow is open source and still early. Feedback on the workflow, installation experience, and documentation model is very welcome:

https://github.com/MedAdemBHA/docflow

#OpenSource #DeveloperTools #AIAgents #Documentation #SoftwareEngineering

### LinkedIn — context optimization angle

“Token optimization” is often presented as a vague claim, so I wanted DocFlow’s approach to be measurable and explicit.

DocFlow does not compress documentation. It changes the loading strategy:

1. Load up to 30 non-empty lines from `docs/INDEX.md`.
2. Load up to 20 lines from the latest changelog summary.
3. Route the task to one exact product spec, technical spec, decision, plan, review, or reference.
4. Open more documents only when the task actually needs them.

Across two established repositories, the initial documentation payload went from 127,424 to 605 words and from 129,865 to 481 words—99.53% and 99.63% initially avoided.

Those are word-count measurements, not guaranteed total-task token savings. Source code and task-specific documents still enter context.

Method, caveats, and source: https://github.com/MedAdemBHA/docflow

## Reddit

### Suggested title

I built an open-source Markdown memory system for AI coding agents

### Post body

I kept running into the same problem with coding agents: a new session often has to rediscover the product, architecture, decisions, roadmap, and recent changes.

So I built **DocFlow**, an open-source documentation workflow based on plain Markdown and small Bash helpers.

The core idea is simple:

- `product-spec/` records **WHAT** the product does
- `specs/` records **HOW** it works
- `decisions/` records **WHY** choices were made
- `changelog/` records what **SHIPPED**
- `INDEX.md` gives the agent a compact route map before it opens full docs

It includes a doctor that chooses between initializing new docs, adopting existing docs without rewriting them, or repairing generated helpers. It also validates broken links, stale maps, headings, and document structure.

The Claude Code plugin works now, and the portable repository guidance works with Codex, Gemini, Cursor, and similar agents. The public Codex plugin listing is not published yet.

Repo and runnable example: https://github.com/MedAdemBHA/docflow

I would especially value feedback on whether the structure feels useful in a real repository and where the setup still feels confusing.

## Quora

### Suggested question

How can I give an AI coding agent persistent project context without loading all documentation every time?

### Answer

One practical approach is to keep durable project knowledge in a predictable Markdown structure and give the agent a compact index before it reads full documents.

I built an open-source tool called **DocFlow** around that model. It separates product behavior (**WHAT**), technical implementation (**HOW**), architecture decisions (**WHY**), plans, reviews, and shipped work. The agent starts with a short `path → purpose` map and recent changelog context, then opens only the document relevant to the task.

This does not create true model memory, and it does not guarantee a fixed token saving for every task. It makes repository context durable, reviewable, and easier to route. Because the source of truth is plain Markdown, humans can inspect and edit everything without a proprietary database.

DocFlow can scaffold a new documentation system or adopt existing docs without rewriting them. It currently supports Claude Code directly and provides repository guidance for Codex, Gemini, Cursor, and other agents.

Disclosure: I built the project. The source, setup instructions, measurements, and runnable example are here:

https://github.com/MedAdemBHA/docflow

## Posting Notes

- Upload the feature-overview PNG directly instead of relying on a link preview.
- Keep the repository URL visible in the post text.
- On Reddit, choose a relevant community and read its self-promotion rules before posting.
- On Quora, answer a real question and retain the disclosure that you built DocFlow.
- Replace broad hashtags with community-specific tags when appropriate.
