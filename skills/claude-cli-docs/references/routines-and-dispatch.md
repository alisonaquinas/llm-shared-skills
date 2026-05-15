# Claude Code — Routines, Scheduling, Dispatch

Index of the scheduling and cross-device surfaces in Claude Code. The agent should
WebFetch the canonical pages below when the user asks about cron jobs, recurring tasks,
remote control, or moving a session between surfaces.

## Key Pages

| Topic | URL |
| --- | --- |
| Routines (cron-scheduled remote agents) | <https://code.claude.com/docs/en/routines> |
| Remote control / cross-device dispatch | <https://code.claude.com/docs/en/remote-control> |
| Channels (messaging-platform webhooks) | <https://code.claude.com/docs/en/channels> |
| GitHub Actions integration | <https://code.claude.com/docs/en/github-actions> |
| GitLab CI/CD integration | <https://code.claude.com/docs/en/gitlab-ci-cd> |

## Routines

A routine is a saved prompt that runs on a cron schedule against a remote Claude Code
runner. Use it for recurring jobs like "every weekday at 09:00, summarize overnight CI
failures and post to Slack."

Manage routines from the CLI or the desktop app:

```text
# Create a routine conversationally — Claude walks through prompt, repos, env, schedule
/schedule

# Create from a natural-language description (recurring or one-off)
/schedule daily PR review at 9am
/schedule in 2 weeks, open a cleanup PR removing the feature flag

# Manage existing routines
/schedule list                              # list all routines for this account
/schedule update                            # change a routine's config
/schedule run                               # trigger a routine immediately
```

The CLI's `/schedule` creates **scheduled** triggers only. To add an **API** trigger
(per-routine bearer token + HTTP endpoint) or a **GitHub** event trigger, edit the
routine from the web at <https://claude.ai/code/routines>. The minimum recurring
interval is one hour.

Full docs: <https://code.claude.com/docs/en/routines>

## Loop (Self-Paced Recurring Prompts)

`/loop` runs a prompt or slash command on a recurring interval inside the current
session. Use it when the cadence should be local rather than scheduled on a remote
runner.

```text
/loop 5m /check-deploy           # run /check-deploy every 5 minutes
/loop /poll-queue                # let the model pick the cadence
```

## Remote Control & Teleport

Move a session between surfaces (terminal, desktop, web, iOS) without restarting the
conversation. The session ID is the linkage.

```bash
# In terminal: resume by session ID (the orchestrator survives)
claude --resume <session-id>

# In a web or iOS session: jump back into the terminal
/teleport
```

Full docs: <https://code.claude.com/docs/en/remote-control>

## Desktop Scheduled Tasks

The desktop app supports local scheduled tasks (no remote runner needed). These run on
the workstation that owns the desktop session and are useful for tasks that depend on
local credentials, mounted drives, or the local filesystem.

Configure via the desktop app's scheduled-tasks UI, or by editing
`~/.claude/scheduled-tasks.json`.

## CI/CD-Triggered Runs

For routines driven by external pipelines rather than cron, use either an API trigger
on the routine itself, or the standalone CI/CD integrations:

- **API trigger on a routine** — POST to the routine's `/fire` endpoint with a bearer
  token; an optional `text` body is passed to the routine alongside its saved prompt.
  Currently behind the `experimental-cc-routine-2026-04-01` beta header. See the
  Routines docs (`https://code.claude.com/docs/en/routines`) for the full request shape.
- **GitHub Actions** — `anthropics/claude-code-action@v1`. See
  <https://code.claude.com/docs/en/github-actions> for inputs, secrets, and example
  workflows.
- **GitLab CI/CD** — see <https://code.claude.com/docs/en/gitlab-ci-cd> for the
  reference job template and required CI variables.

## Channels

Channels bridge routine output and scheduled-task results into messaging surfaces
(Telegram, Discord, iMessage, etc.) via webhooks. Useful when the user needs a routine
to "ping me when X happens" rather than writing into a file or terminal.

Full docs: <https://code.claude.com/docs/en/channels>

## Notes

- Routines bill the runner running the schedule, not the surface that displays the
  output. Channel webhooks and CI runs each have their own quota model — consult the
  pricing page on platform.claude.com for current limits.
- A routine cannot interactively prompt the user; design prompts so they can complete
  without follow-up input, or persist state to a file the next run can read.
