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
    model="claude-sonnet-4-6",
    max_tokens=1024,
    tools=tools,
    messages=[{"role": "user", "content": "What's the weather in NYC?"}]
)
```

## Context Window Notes

- Default: 200K tokens (~150K words)
- 1M token beta: available for Opus 4.6 and Sonnet 4.6 with `context-1m-2025-08-07` beta header
- Long context pricing applies above 200K tokens

## Prompt Caching

Reduces cost and latency for repeated large prompts. Mark cacheable blocks with
`"cache_control": {"type": "ephemeral"}`. See the prompt caching docs for TTL details.
