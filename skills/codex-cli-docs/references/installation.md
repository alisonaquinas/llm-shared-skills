# Codex CLI — Installation & Authentication

## Key Pages

| Page | URL |
| --- | --- |
| CLI overview | <https://developers.openai.com/codex/cli> |
| Authentication | <https://developers.openai.com/codex/auth> |
| GitHub README | <https://github.com/openai/codex/blob/main/README.md> |

## Install

```bash
# npm (global install)
npm install -g @openai/codex

# Homebrew (macOS/Linux)
brew install codex
```

## Authentication

### Sign in with ChatGPT account (Plus/Pro/Team/Edu/Enterprise)

```bash
codex auth login
```

This opens a browser window to authenticate with your OpenAI account.

### Sign in with API key

```bash
export OPENAI_API_KEY=your-key-here
```

Or pass it directly:

```bash
codex --api-key sk-... "fix the tests"
```

Full auth docs: <https://developers.openai.com/codex/auth#sign-in-with-an-api-key>

## First Run

```bash
cd your-project
codex "describe what this codebase does"
```

## System Requirements

- Node.js 18+ (for npm install)
- macOS, Linux, or Windows (WSL recommended on Windows)
- An OpenAI account (ChatGPT plan) or API key

## Releases & Changelog

<https://github.com/openai/codex/releases>
