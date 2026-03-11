# Claude API — Extended Thinking

## Key Pages

| Topic | URL |
| --- | --- |
| Extended thinking | <https://platform.claude.com/docs/en/build-with-claude/extended-thinking> |
| Adaptive thinking | <https://platform.claude.com/docs/en/build-with-claude/adaptive-thinking> |

## What is Extended Thinking?

Extended thinking lets Claude reason through complex problems before responding.
Claude produces internal `thinking` blocks, then a final `text` response.

Supported by: Claude Opus 4.6, Sonnet 4.6, Haiku 4.5

## Extended Thinking — Quick Shape

```python
response = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=16000,
    thinking={
        "type": "enabled",
        "budget_tokens": 10000  # how many tokens Claude can use for thinking
    },
    messages=[{"role": "user", "content": "Solve this step by step: ..."}]
)

for block in response.content:
    if block.type == "thinking":
        print("Thinking:", block.thinking)
    elif block.type == "text":
        print("Answer:", block.text)
```

## Adaptive Thinking

Adaptive thinking automatically adjusts the thinking budget based on task complexity.
Supported by: Claude Opus 4.6, Sonnet 4.6 (not Haiku 4.5).

```python
thinking={"type": "auto"}  # Claude decides budget automatically
```

## Tips

- `budget_tokens` must be ≥ 1024 and less than `max_tokens`
- Thinking tokens are billed at the same rate as output tokens
- Use extended thinking for math, coding, multi-step reasoning, and planning tasks
