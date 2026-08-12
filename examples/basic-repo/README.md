# Example App

This is a small but complete DocFlow repository. It demonstrates the files an agent receives, how project questions route to durable documentation, and how shipped work becomes context for the next session.

## Try The Demo

From the DocFlow repository root:

```bash
bash examples/basic-repo/scripts/docflow-check.sh --target examples/basic-repo
CLAUDE_PROJECT_DIR="$PWD/examples/basic-repo" bash hooks/docflow-context.sh
```

The first command should report `Ready`. The second prints the bounded documentation map and recent changelog context that an agent receives.

## Follow One Feature

The example’s session-context behavior is connected across four durable views:

1. [Product overview](docs/product-spec/00-overview.md) explains who benefits and why.
2. [Technical spec](<docs/specs/(jun-26)-context-hook.md>) explains how it works.
3. [ADR 0001](docs/decisions/0001-session-context-hook.md) records why the hook is read-only.
4. [June changelog](<docs/changelog/(jun-26).md>) records what shipped.

## Try These Prompts

- “What does this app do?”
- “How does the context hook work?”
- “Why did we choose a read-only hook?”
- “What is planned next?”
- “What shipped most recently?”
- “Are there known bugs?”

## Documentation

Start with the [human documentation hub](docs/README.md). Agents start with [AGENTS.md](AGENTS.md) and the compact [docs/INDEX.md](docs/INDEX.md).
