# Claude API — Agent SDK

## Key Pages

| Topic | URL |
| --- | --- |
| Agent SDK overview | <https://platform.claude.com/docs/en/agent-sdk/overview> |
| Service tiers | <https://platform.claude.com/docs/en/api/service-tiers> |

## What is the Agent SDK?

The Agent SDK enables building custom agents powered by Claude Code's tools and
capabilities, with full control over orchestration, tool access, and permissions.
It is separate from the Messages API and designed for agentic coding workflows.

## Multi-Agent Patterns

Claude supports spawning sub-agents for parallelizing complex tasks:

- A lead/orchestrator agent breaks work into subtasks
- Sub-agents execute subtasks in parallel
- Orchestrator merges results

See the Agent SDK docs for full orchestration primitives and patterns.

## Related: Claude Code Sub-Agents

For Claude Code (CLI) sub-agent docs, see the `claude-cli-docs` skill →
`references/workflows.md`

## Agent SDK vs Messages API

| | Messages API | Agent SDK |
| --- | --- | --- |
| Use case | Single-turn or multi-turn chat | Agentic coding workflows |
| Tool access | User-defined tools | Claude Code tools (file edit, bash, etc.) |
| Orchestration | Manual | Built-in multi-agent primitives |
