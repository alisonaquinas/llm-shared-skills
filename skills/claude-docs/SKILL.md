---
name: claude-docs
description: >
  Use this skill to look up, navigate, or find anything in the official Anthropic
  Claude API documentation at platform.claude.com/docs. Trigger when the user asks
  about Claude API endpoints, model IDs, pricing, prompt engineering, tool use,
  extended thinking, adaptive thinking, context windows (200K, 1M context),
  prompt caching (TTL, workspace-level isolation), vision, files API, batch API,
  the Agent SDK, rate limits, authentication, error codes, or any
  Anthropic/Claude developer reference. Also trigger for questions like
  "where is the Claude doc for X", "what does the Claude API reference say
  about Y", "find the Anthropic docs on Z", or any request to look something
  up in Claude/Anthropic documentation.
---

# Claude API Docs

Reference skill for navigating official Anthropic Claude documentation at
**<https://platform.claude.com/docs/en/>**

Full page index: <https://platform.claude.com/docs/llms.txt>

---

## Intent Router

| Topic | Reference file | Load when... |
| --- | --- | --- |
| Getting started, intro, quickstart | `references/getting-started.md` | user needs first API call, setup, or intro overview |
| Models, model IDs, pricing | `references/models.md` | user asks about model names, context windows, pricing, or which model to use |
| Prompt engineering, tool use, vision | `references/build-with-claude.md` | user asks about prompting, function/tool use, image input, streaming, context |
| Extended thinking, adaptive thinking | `references/extended-thinking.md` | user asks about thinking tokens, budget, extended/adaptive thinking |
| Agent SDK, sub-agents, orchestration | `references/agent-sdk.md` | user asks about building agents, multi-agent, orchestration, Agent SDK |
| REST API endpoints, auth, rate limits | `references/api-reference.md` | user asks about HTTP endpoints, authentication, rate limits, errors, SDKs |

---

## Key URLs at a Glance

```text
Root               https://platform.claude.com/docs/en/
Intro              https://platform.claude.com/docs/en/intro
Get started        https://platform.claude.com/docs/en/get-started
Models             https://platform.claude.com/docs/en/about-claude/models/overview
Pricing            https://platform.claude.com/docs/en/about-claude/pricing
Prompt engineering https://platform.claude.com/docs/en/build-with-claude/prompt-engineering
Tool use           https://platform.claude.com/docs/en/build-with-claude/tool-use
Extended thinking  https://platform.claude.com/docs/en/build-with-claude/extended-thinking
Context windows    https://platform.claude.com/docs/en/build-with-claude/context-windows
Vision             https://platform.claude.com/docs/en/build-with-claude/vision
Agent SDK          https://platform.claude.com/docs/en/agent-sdk/overview
API reference      https://platform.claude.com/docs/en/api/
```

---

## Current Model IDs (quick reference)

Authoritative list, including AWS Bedrock and GCP Vertex IDs and current GA status:
<https://platform.claude.com/docs/en/about-claude/models/overview>

Use the canonical overview page when picking a model or constructing a request — it
reflects the current GA generation without going stale here. For the current
deprecation schedule, see
<https://platform.claude.com/docs/en/about-claude/model-deprecations>.

For a curated cross-platform map (Bedrock + Vertex IDs, capability flags, selection
guidance) see `references/models.md`.
