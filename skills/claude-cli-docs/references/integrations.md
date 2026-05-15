# Claude Code CLI — Integrations

## Key Pages

| Integration | URL |
| --- | --- |
| GitHub Actions | <https://code.claude.com/docs/en/github-actions> |
| Code review (auto PR review) | <https://code.claude.com/docs/en/code-review> |
| GitLab CI/CD | <https://code.claude.com/docs/en/gitlab-ci-cd> |
| VS Code extension | <https://code.claude.com/docs/en/vs-code> |
| JetBrains plugin | <https://code.claude.com/docs/en/jetbrains> |
| Desktop app | <https://code.claude.com/docs/en/desktop> |
| Web (claude.ai/code) | <https://code.claude.com/docs/en/claude-code-on-the-web> |
| Remote control | <https://code.claude.com/docs/en/remote-control> |
| Slack | <https://code.claude.com/docs/en/slack> |
| Chrome | <https://code.claude.com/docs/en/chrome> |
| Channels (Telegram / Discord / iMessage webhooks) | <https://code.claude.com/docs/en/channels> |
| Routines & scheduling | <https://code.claude.com/docs/en/routines> |

## GitHub Actions

Run Claude Code in CI to automate PR reviews, issue triage, and code tasks:

```yaml
# .github/workflows/claude.yml
name: Claude Code Review
on:
  pull_request:
jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: anthropics/claude-code-action@v1
        with:
          anthropic-api-key: ${{ secrets.ANTHROPIC_API_KEY }}
```

Full docs: <https://code.claude.com/docs/en/github-actions>

## VS Code Extension

Install: search "Claude Code" in Extensions (`Ctrl+Shift+X`), or:

```text
vscode:extension/anthropic.claude-code
```

Provides: inline diffs, @-mentions, plan review, conversation history in editor.

## JetBrains Plugin

Install from JetBrains Marketplace by searching "Claude Code Beta".
Supports: IntelliJ IDEA, PyCharm, WebStorm, and other JetBrains IDEs.

## Slack Integration

Mention `@Claude` in Slack with a task (e.g., a bug report) and get a pull request back.
Setup: <https://code.claude.com/docs/en/slack>

## Remote Control

Continue a local terminal session from your phone or any browser:
<https://code.claude.com/docs/en/remote-control>

Use `/teleport` to move a web/iOS session into your terminal.

## Channels

Bridge Claude Code conversations into messaging platforms via webhooks (Telegram,
Discord, iMessage, and other chat surfaces). Useful for receiving long-running task
output on a phone or for triggering agents from a group chat.

Full docs: <https://code.claude.com/docs/en/channels>

## Routines & Scheduling

Create cron-scheduled remote agents (routines) and recurring local tasks. See
`references/routines-and-dispatch.md` for the full index, or jump directly to:

- Routines overview: <https://code.claude.com/docs/en/routines>
- GitHub Actions integration: <https://code.claude.com/docs/en/github-actions>
- GitLab CI/CD integration: <https://code.claude.com/docs/en/gitlab-ci-cd>
