# Claude API — Getting Started

## Key Pages

| Page | URL |
| --- | --- |
| Intro to Claude | <https://platform.claude.com/docs/en/intro> |
| Quickstart (first API call) | <https://platform.claude.com/docs/en/get-started> |
| Claude Console (test prompts in browser) | <https://console.anthropic.com/> |
| Support | <https://support.claude.com/> |
| Discord community | <https://www.anthropic.com/discord> |

## First API Call (Python)

```python
import anthropic

client = anthropic.Anthropic()  # reads ANTHROPIC_API_KEY from env

message = client.messages.create(
    model="<current-sonnet-id>",  # see https://platform.claude.com/docs/en/about-claude/models/overview
    max_tokens=1024,
    messages=[{"role": "user", "content": "Hello, Claude"}]
)
print(message.content)
```

## SDKs

| SDK | Install |
| --- | --- |
| Python | `pip install anthropic` |
| TypeScript/JS | `npm install @anthropic-ai/sdk` |
| REST | Direct HTTP to `https://api.anthropic.com/v1/messages` |

## Authentication

Set the `ANTHROPIC_API_KEY` environment variable, or pass `api_key=` to the client.
API keys are created at: <https://console.anthropic.com/settings/keys>
