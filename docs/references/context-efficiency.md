<!-- docflow: reference. Context-loading contract, measurement method, and observed results. -->
# Context Efficiency

DocFlow reduces the documentation placed in an agent's initial context. It does not claim to compress Markdown or guarantee a fixed token bill for an entire task.

## Loading Contract

| Stage | Loaded content | Bound |
|---|---|---:|
| Session routing | Non-empty lines from `docs/INDEX.md` | 60 lines by default |
| Recent history | Header, summary, and newest detailed entry from the newest valid monthly changelog | 38 lines by default |
| Task work | Exact documents selected through the index and repository guidance | Unbounded; driven by task scope |

`DOCFLOW_INDEX_LINES` and `DOCFLOW_LOG_LINES` override the two automatic limits with positive integers.

Claude receives the bounded routing/history payload through the `SessionStart` hook. Codex, Gemini, Cursor, and other repo-aware agents use the same index-first workflow through `AGENTS.md`, but their automatic loading behavior depends on the host product.

## Measurement Method

The reproducible comparison uses words rather than model-specific tokens:

```bash
repo=/path/to/repo

find "$repo/docs" -type f -name '*.md' -print0 \
  | xargs -0 wc -w \
  | tail -n 1

CLAUDE_PROJECT_DIR="$repo" \
  bash /path/to/docflow/hooks/docflow-context.sh \
  | wc -w
```

Initial context avoided is:

```text
(1 - automatic_context_words / all_docs_words) × 100
```

This measures the text boundary controlled by the hook. It does not include system instructions, conversation history, source code, tool results, `docs/README.md`, or task-specific documents opened later.

## Observed Results

Measured on 2026-08-13 using the default limits:

| Repository | Docs files | Full docs words | `INDEX.md` words | Hook words | Initial context avoided |
|---|---:|---:|---:|---:|---:|
| Company Hub (`BO-`) | 117 | 127,424 | 738 | 847 | 99.34% |
| AutoÉcole Pro (`BO`) | 105 | 129,865 | 727 | 810 | 99.38% |

The hook output can be smaller than `INDEX.md` because only the first 60 non-empty index lines are emitted. The bounded changelog excerpt contributes the remaining recent-history context.

## Interpretation

| Claim | Supported? | Reason |
|---|---|---|
| DocFlow greatly reduces automatic documentation context | Yes | Both measured repositories avoid more than 99% of the full docs corpus initially |
| Every task costs 99% fewer tokens | No | Agents still load source code and task-specific documentation |
| Word reduction equals exact token reduction | No | Tokenization varies by model and content |
| Large audits always stay small | No | Whole-product reviews may legitimately require many documents |
| Route-first work is cheaper than scanning all docs | Yes | The index selects a small relevant subset before full documents are opened |

## Guardrails

- Keep each `INDEX.md` entry to one path and one short purpose.
- Put the current outcome at the start of the monthly changelog summary.
- Put the newest detailed changelog entry before older entries.
- Open full changelog history only when the task needs historical detail.
- Measure again when hook defaults or repository documentation size changes.

## Update Log

| Date | Change | Ref |
|---|---|---|
| 2026-08-13 | Documented the context-loading contract and two-repository measurements. | `context-efficiency` |
