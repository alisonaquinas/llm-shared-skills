# Claude API — Extended Thinking

## Key Pages

| Topic | URL |
| --- | --- |
| Extended thinking | <https://platform.claude.com/docs/en/build-with-claude/extended-thinking> |
| Adaptive thinking | <https://platform.claude.com/docs/en/build-with-claude/adaptive-thinking> |

## What is Extended Thinking?

Extended thinking lets Claude reason through complex problems before responding.
Claude produces internal `thinking` blocks, then a final `text` response.

Supported by: all current GA Claude generations. Capability flags per model are listed
at <https://platform.claude.com/docs/en/about-claude/models/overview>.

## Extended Thinking — Quick Shape

```python
response = client.messages.create(
    model="<current-sonnet-id>",  # see models/overview for the GA alias
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

Adaptive thinking automatically adjusts the thinking budget based on task complexity,
trading off cost and quality without a hard-coded budget. Available on the current
Opus and Sonnet generations (not on Haiku). Canonical reference:
<https://platform.claude.com/docs/en/build-with-claude/adaptive-thinking>.

```python
thinking={"type": "auto"}  # Claude decides budget automatically
```

Adaptive thinking and explicit `budget_tokens` are mutually exclusive in a single
request — pick one. Use adaptive when the workload mix is unpredictable (mixed easy
and hard turns); use explicit budgets when you need a hard cost ceiling per turn.

On the current top-tier Opus generation, **adaptive is the only supported thinking
mode** — manual `{"type": "enabled", "budget_tokens": N}` is rejected with a 400.
On the surrounding Opus/Sonnet generations, manual mode still works but is deprecated
in favor of adaptive. Check
<https://platform.claude.com/docs/en/build-with-claude/adaptive-thinking> for the
current per-model availability matrix.

Adaptive thinking is composed with the **effort** parameter (`low` / `medium` / `high`
/ `xhigh` / `max`) to soft-cap how much thinking Claude does on each turn. See
<https://platform.claude.com/docs/en/build-with-claude/effort>.

## Tips

- For explicit budgets, `budget_tokens` must be ≥ 1024 and less than `max_tokens`.
- Thinking tokens are billed at the same rate as output tokens.
- Use extended thinking for math, coding, multi-step reasoning, and planning tasks.
- Adaptive thinking pairs well with prompt caching: a cached system prompt + adaptive
  budget gives the lowest cost per agentic turn for repeat workloads. See
  `references/build-with-claude.md` for the caching cross-reference.
