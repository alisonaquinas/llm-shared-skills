# Claude API — REST API Reference

## Key Pages

| Topic | URL |
| --- | --- |
| API reference root | <https://platform.claude.com/docs/en/api/> |
| Messages endpoint | <https://platform.claude.com/docs/en/api/messages> |
| Authentication | <https://platform.claude.com/docs/en/api/getting-started> |
| Rate limits | <https://platform.claude.com/docs/en/api/rate-limits> |
| Errors | <https://platform.claude.com/docs/en/api/errors> |
| Service tiers | <https://platform.claude.com/docs/en/api/service-tiers> |
| Versions | <https://platform.claude.com/docs/en/api/versioning> |

## Base URL

```text
https://api.anthropic.com
```

## Authentication

```http
x-api-key: YOUR_API_KEY
anthropic-version: 2023-06-01
content-type: application/json
```

## Messages Endpoint

```http
POST /v1/messages
```

### Minimal request body

```json
{
  "model": "claude-sonnet-4-6",
  "max_tokens": 1024,
  "messages": [
    {"role": "user", "content": "Hello"}
  ]
}
```

## Rate Limits

Rate limits are per API key and vary by tier. Check your tier at:
<https://console.anthropic.com/settings/limits>

## Common Error Codes

| Code | Meaning |
| --- | --- |
| 400 | Bad request (invalid parameters) |
| 401 | Authentication error (bad API key) |
| 403 | Permission denied |
| 429 | Rate limit exceeded |
| 500 | Anthropic server error |
| 529 | Overloaded — retry with exponential backoff |
