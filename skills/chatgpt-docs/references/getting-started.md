# OpenAI Platform — Getting Started

## Key Pages

| Page | URL |
| --- | --- |
| Overview | <https://platform.openai.com/docs/overview> |
| Quickstart | <https://platform.openai.com/docs/quickstart> |
| OpenAI Dashboard | <https://platform.openai.com/> |
| API Keys | <https://platform.openai.com/api-keys> |
| Usage & billing | <https://platform.openai.com/usage> |

## First API Call (Python)

```python
from openai import OpenAI

client = OpenAI()  # reads OPENAI_API_KEY from env

response = client.chat.completions.create(
    model="gpt-4o",
    messages=[{"role": "user", "content": "Hello!"}]
)
print(response.choices[0].message.content)
```

## SDKs

| SDK | Install |
| --- | --- |
| Python | `pip install openai` |
| Node.js | `npm install openai` |
| REST | Direct HTTP to `https://api.openai.com/v1/` |

## Authentication

Set the `OPENAI_API_KEY` environment variable, or pass `api_key=` to the client.
Keys are managed at: <https://platform.openai.com/api-keys>
