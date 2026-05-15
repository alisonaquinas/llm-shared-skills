# Claude API — Models

## Reference Page

<https://platform.claude.com/docs/en/about-claude/models/overview>

## Pricing Page

<https://platform.claude.com/docs/en/about-claude/pricing>

## Current Models

The canonical list of currently-GA Claude models, with exact API IDs, context windows,
and capability flags, lives at
<https://platform.claude.com/docs/en/about-claude/models/overview>. Read it rather
than caching specific IDs here — the GA set rotates as new model generations ship.

As of mid-2026, the high-level shape is:

- Two tiers in the **Opus** line and the **Sonnet** line expose a **1M-token context
  window** (the 200K default plus a 1M opt-in via the long-context beta header).
- The **Haiku** line targets latency and throughput; current Haiku context window is
  200K.
- All current GA models support text input, image input (vision), text output, and
  multilingual responses.
- Extended thinking is available across the line; **adaptive thinking** (auto budget)
  is available on Opus and Sonnet generations, not Haiku.

For a specific API ID, the AWS Bedrock variant, or the GCP Vertex variant, consult the
overview page or the model-card link from there. Pinned IDs intentionally are not
listed in this file to avoid silent drift.

## Pricing

Current per-million-token pricing for every GA model:
<https://platform.claude.com/docs/en/about-claude/pricing>

## Model Selection Guide

- **Most complex tasks / agents / coding**: latest **Opus** generation.
- **Balanced speed + intelligence**: latest **Sonnet** generation.
- **Fastest / high-volume**: latest **Haiku** generation.

When the user does not pin a specific model, prefer the latest GA Opus generation for
coding agents and the latest GA Sonnet generation for balanced workloads.

## Deprecations

Canonical deprecation schedule:
<https://platform.claude.com/docs/en/about-claude/model-deprecations>

Track the schedule from that page rather than from this file — once a date passes, the
entry typically rotates off the schedule and the model becomes unavailable.
