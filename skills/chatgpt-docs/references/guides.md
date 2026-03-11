# OpenAI Platform — Guides & Features

## Key Guide Pages

| Topic | URL |
| --- | --- |
| Function calling | <https://platform.openai.com/docs/guides/function-calling> |
| Structured outputs | <https://platform.openai.com/docs/guides/structured-outputs> |
| Streaming | <https://platform.openai.com/docs/guides/streaming> |
| Vision (image input) | <https://platform.openai.com/docs/guides/vision> |
| Assistants API | <https://platform.openai.com/docs/assistants/overview> |
| Responses vs Chat Completions | <https://platform.openai.com/docs/guides/responses-vs-chat-completions> |
| Fine-tuning | <https://platform.openai.com/docs/guides/fine-tuning> |
| Embeddings | <https://platform.openai.com/docs/guides/embeddings> |
| Moderation | <https://platform.openai.com/docs/guides/moderation> |
| Prompt engineering | <https://platform.openai.com/docs/guides/prompt-engineering> |
| Production best practices | <https://platform.openai.com/docs/guides/production-best-practices> |
| Safety best practices | <https://platform.openai.com/docs/guides/safety-best-practices> |

## Function Calling — Quick Shape

```python
tools = [{
    "type": "function",
    "function": {
        "name": "get_weather",
        "description": "Get the current weather",
        "parameters": {
            "type": "object",
            "properties": {
                "location": {"type": "string"}
            },
            "required": ["location"]
        }
    }
}]

response = client.chat.completions.create(
    model="gpt-4o",
    messages=[{"role": "user", "content": "What's the weather in NYC?"}],
    tools=tools,
    tool_choice="auto"
)
```

## Assistants API vs Chat Completions

- **Chat Completions**: Stateless, one-shot, you manage history — simpler
- **Responses API**: New stateful alternative to Assistants, manages context server-side
- **Assistants API**: Stateful with threads, supports files, code interpreter, retrieval
