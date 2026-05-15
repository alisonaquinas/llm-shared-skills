# Claude API — Build with Claude

## Key Pages

| Topic | URL |
| --- | --- |
| Prompt engineering overview | <https://platform.claude.com/docs/en/build-with-claude/prompt-engineering> |
| Prompting best practices | <https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices> |
| Tool use (function calling) | <https://platform.claude.com/docs/en/build-with-claude/tool-use> |
| Vision (image input) | <https://platform.claude.com/docs/en/build-with-claude/vision> |
| Context windows | <https://platform.claude.com/docs/en/build-with-claude/context-windows> |
| Streaming | <https://platform.claude.com/docs/en/build-with-claude/streaming> |
| Batch API | <https://platform.claude.com/docs/en/build-with-claude/message-batches> |
| Prompt caching | <https://platform.claude.com/docs/en/build-with-claude/prompt-caching> |
| Files API | <https://platform.claude.com/docs/en/build-with-claude/files> |
| Embeddings | <https://platform.claude.com/docs/en/build-with-claude/embeddings> |
| Computer use | <https://platform.claude.com/docs/en/build-with-claude/computer-use> |

## Tool Use (Function Calling) — Quick Shape

```python
tools = [{
    "name": "get_weather",
    "description": "Get current weather for a location",
    "input_schema": {
        "type": "object",
        "properties": {
            "location": {"type": "string", "description": "City, State"}
        },
        "required": ["location"]
    }
}]

response = client.messages.create(
    model="<current-sonnet-id>",  # see models/overview for the GA alias
    max_tokens=1024,
    tools=tools,
    messages=[{"role": "user", "content": "What's the weather in NYC?"}]
)
```

## Context Window Notes

- Default: 200K tokens (~150K words)
- 1M context: available on the current Opus and Sonnet generations via the long-context
  beta header. Canonical instructions and current header value live at
  <https://platform.claude.com/docs/en/build-with-claude/context-windows>.
- Long-context pricing applies above 200K tokens — consult the pricing page for the
  current tier.

## Prompt Caching

Reduces cost and latency for repeated large prompts (system instructions, tool schemas,
long documents).

```python
# Mark a system block as cacheable
messages=[{
    "role": "user",
    "content": [
        {
            "type": "text",
            "text": "<long shared context>",
            "cache_control": {"type": "ephemeral"}
        },
        {"type": "text", "text": "<turn-specific question>"}
    ]
}]
```

Key operational facts:

- **Default TTL** is **5 minutes**. The previous 1-hour default was retired in early
  2026; explicitly request the 1-hour TTL via the prompt-caching beta if you need it.
- **Cache scope** is **per workspace**, not per organization. Two workspaces under the
  same org bill independent caches and do not share hits.
- Cache writes are billed at a small premium over standard input tokens; cache reads
  are billed at a steep discount. The exact multipliers and TTL options live at
  <https://platform.claude.com/docs/en/build-with-claude/prompt-caching>.

Pair prompt caching with adaptive thinking (`references/extended-thinking.md`) for the
lowest cost-per-turn on repeat agentic workloads.
