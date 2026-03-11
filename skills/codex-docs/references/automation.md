# OpenAI Codex — Automation

## Key Pages

| Topic | URL |
| --- | --- |
| Automation overview | <https://developers.openai.com/codex/automation> |
| Non-interactive mode | <https://developers.openai.com/codex/automation/non-interactive> |
| SDK | <https://developers.openai.com/codex/automation/sdk> |
| App server | <https://developers.openai.com/codex/automation/app-server> |
| MCP server | <https://developers.openai.com/codex/automation/mcp-server> |
| GitHub Action | <https://developers.openai.com/codex/automation/github-action> |

## GitHub Action

Run Codex tasks automatically in CI/CD:

```yaml
# .github/workflows/codex.yml
name: Codex
on:
  issues:
    types: [labeled]
jobs:
  codex:
    runs-on: ubuntu-latest
    steps:
      - uses: openai/codex-action@v1
        with:
          task: "Fix the issue described in ${{ github.event.issue.body }}"
          openai-api-key: ${{ secrets.OPENAI_API_KEY }}
```

Full reference: <https://developers.openai.com/codex/automation/github-action>

## Non-interactive Mode

Run Codex headlessly from a script or CI pipeline:

```bash
codex --non-interactive "write tests for src/auth.py"
```

## SDK

The Codex SDK allows programmatic task submission and result retrieval:
<https://developers.openai.com/codex/automation/sdk>

Use it to build custom workflows, dashboards, or integrate Codex into existing tooling.
