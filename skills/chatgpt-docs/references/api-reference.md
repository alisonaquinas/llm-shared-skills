# OpenAI Platform — REST API Reference

## Key Pages

| Topic | URL |
| --- | --- |
| API reference root | <https://platform.openai.com/docs/api-reference/introduction> |
| Authentication | <https://platform.openai.com/docs/api-reference/authentication> |
| Chat completions | <https://platform.openai.com/docs/api-reference/chat> |
| Responses API | <https://platform.openai.com/docs/api-reference/responses> |
| Embeddings | <https://platform.openai.com/docs/api-reference/embeddings> |
| Files | <https://platform.openai.com/docs/api-reference/files> |
| Fine-tuning | <https://platform.openai.com/docs/api-reference/fine-tuning> |
| Images (DALL-E) | <https://platform.openai.com/docs/api-reference/images> |
| Audio (Whisper/TTS) | <https://platform.openai.com/docs/api-reference/audio> |
| Moderation | <https://platform.openai.com/docs/api-reference/moderations> |
| Rate limits | <https://platform.openai.com/docs/guides/rate-limits> |
| Error codes | <https://platform.openai.com/docs/guides/error-codes> |

## Base URL

```text
https://api.openai.com/v1
```

## Authentication

```http
Authorization: Bearer YOUR_OPENAI_API_KEY
Content-Type: application/json
```

## Chat Completions — Minimal Request

```json
POST /v1/chat/completions
{
  "model": "gpt-4o",
  "messages": [{"role": "user", "content": "Hello"}]
}
```

## Common Error Codes

| Code | Meaning |
| --- | --- |
| 400 | Bad request |
| 401 | Invalid API key |
| 429 | Rate limit or quota exceeded |
| 500 | OpenAI server error |
