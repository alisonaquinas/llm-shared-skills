---
name: tail-command
description: "Inspect trailing lines and follow live updates with `tail`. Use when users ask for log monitoring, end-of-file sampling, or follow-mode behavior."
---

# tail Command Skill

## Purpose

Use `tail` to inspect file endings and monitor append-only logs in near real time.

## Quick start

```bash

tail --help

```

## Common workflows

1. Read the last 100 lines of a log

```bash

tail -n 100 app.log

```

Use explicit line counts for reproducible context windows.

1. Follow a rotating log file reliably

```bash

tail -n 50 -F /var/log/app.log

```

Use `-F` when log files are rotated or recreated.

1. Follow multiple logs with clear boundaries

```bash

tail -n 20 -f api.log worker.log

```

Headers identify which file each new line comes from.

## Guardrails

- Use `-F` for rotated logs; `-f` alone may stop following after file replacement.

- Set bounded startup context (`-n`) before follow mode to avoid overwhelming output.

- Avoid using `tail` where exact ordering across multiple asynchronous files is required.

## Reproducibility and reporting

- Record the exact command, flags, input paths, and working directory.

- Capture relevant environment details when they affect behavior (OS, tool version, locale, or shell).

- Summarize key output lines and explicitly note filters, truncation, or assumptions.
