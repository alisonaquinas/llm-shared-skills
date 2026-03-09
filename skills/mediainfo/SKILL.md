---
name: mediainfo-command
description: "Inspect media container and stream metadata with `mediainfo`. Use when users ask for codec details, duration/bitrate checks, or machine-readable media metadata export."
---

# mediainfo Command Skill

## Purpose

Use `mediainfo` to report container, audio, and video metadata for diagnostics and QA checks.

## Quick start

```bash

mediainfo --Help

```

## Common workflows

1. Show standard human-readable media summary

```bash

mediainfo sample.mp4

```

Baseline output covers container, stream, and bitrate details.

1. Export metadata as JSON

```bash

mediainfo --Output=JSON sample.mp4

```

JSON output is best for automation and diffable checks.

1. Extract selected fields with custom template

```bash

mediainfo --Inform='Video;%CodecID% %Width%x%Height%' sample.mp4

```

Template mode emits targeted values for scripts/reports.

## Guardrails

- Container metadata does not guarantee decode success on every player/codec stack.

- Use consistent output mode (`text` or `JSON`) across comparisons.

- For batch jobs, capture tool version to avoid template/output drift.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
