# Claude API — Models

## Reference Page

<https://platform.claude.com/docs/en/about-claude/models/overview>

## Pricing Page

<https://platform.claude.com/docs/en/about-claude/pricing>

## Current Models

| Model | API ID | Input $/MTok | Output $/MTok | Context | Max Output |
| --- | --- | --- | --- | --- | --- |
| Claude Opus 4.6 | `claude-opus-4-6` | $5 | $25 | 200K (1M beta) | 128K |
| Claude Sonnet 4.6 | `claude-sonnet-4-6` | $3 | $15 | 200K (1M beta) | 64K |
| Claude Haiku 4.5 | `claude-haiku-4-5-20251001` | $1 | $5 | 200K | 64K |

## Third-Party Platform IDs

| Model | AWS Bedrock ID | GCP Vertex AI ID |
| --- | --- | --- |
| Claude Opus 4.6 | `anthropic.claude-opus-4-6-v1` | `claude-opus-4-6` |
| Claude Sonnet 4.6 | `anthropic.claude-sonnet-4-6` | `claude-sonnet-4-6` |
| Claude Haiku 4.5 | `anthropic.claude-haiku-4-5-20251001-v1:0` | `claude-haiku-4-5@20251001` |

## Capability Flags

All current models support: text input, image input (vision), text output, multilingual, extended thinking, adaptive thinking (Opus/Sonnet only).

## Model Selection Guide

- **Most complex tasks / agents / coding**: Claude Opus 4.6
- **Balanced speed + intelligence**: Claude Sonnet 4.6
- **Fastest / high-volume**: Claude Haiku 4.5

## Deprecations

<https://platform.claude.com/docs/en/about-claude/model-deprecations>

Claude Haiku 3 (`claude-3-haiku-20240307`) retires **April 19, 2026** — migrate to Haiku 4.5.
