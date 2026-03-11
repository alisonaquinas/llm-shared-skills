---
name: chatgpt-docs
description: >
  Use this skill to look up, navigate, or find anything in the official OpenAI
  platform documentation at platform.openai.com/docs. Trigger when the user asks
  about the OpenAI API, ChatGPT API, GPT model IDs, OpenAI pricing, function
  calling, the Assistants API, Responses API, fine-tuning, embeddings, moderation,
  DALL-E, Whisper, OpenAI authentication, rate limits, or any OpenAI developer
  reference. Also trigger for "find the OpenAI docs on X", "where does the OpenAI
  API reference cover Y", "what does the ChatGPT API support", or any request to
  look something up in OpenAI/ChatGPT documentation.
---

# ChatGPT / OpenAI Platform Docs

Reference skill for navigating official OpenAI documentation at
**<https://platform.openai.com/docs/>**

---

## Intent Router

| Topic | Reference file | Load when... |
| --- | --- | --- |
| Getting started, API keys, quickstart | `references/getting-started.md` | user needs setup, first API call, or overview |
| Models, model IDs, capabilities | `references/models.md` | user asks about GPT-4o, o1, o3, model selection, or pricing |
| REST API endpoints, authentication | `references/api-reference.md` | user asks about HTTP endpoints, auth headers, rate limits, errors |
| Function calling, Assistants, streaming | `references/guides.md` | user asks about capabilities, features, or how-to topics |

---

## Key URLs at a Glance

```text
Root                 https://platform.openai.com/docs/
Overview             https://platform.openai.com/docs/overview
Models               https://platform.openai.com/docs/models
API reference        https://platform.openai.com/docs/api-reference/introduction
Authentication       https://platform.openai.com/docs/api-reference/authentication
Guides               https://platform.openai.com/docs/guides
Function calling     https://platform.openai.com/docs/guides/function-calling
Assistants API       https://platform.openai.com/docs/assistants/overview
Responses API        https://platform.openai.com/docs/guides/responses-vs-chat-completions
Fine-tuning          https://platform.openai.com/docs/guides/fine-tuning
Embeddings           https://platform.openai.com/docs/guides/embeddings
Moderation           https://platform.openai.com/docs/guides/moderation
Rate limits          https://platform.openai.com/docs/guides/rate-limits
Errors               https://platform.openai.com/docs/guides/error-codes
```

---

## Current Models (quick reference)

| Model | Notes |
| --- | --- |
| `gpt-4o` | Flagship multimodal model (text + vision) |
| `gpt-4o-mini` | Fast, affordable, capable |
| `o1` | Advanced reasoning (chain-of-thought) |
| `o3` | Latest reasoning model |
| `o4-mini` | Fast reasoning model |

Full model list → `references/models.md`
