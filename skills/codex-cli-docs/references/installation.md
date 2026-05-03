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

# Homebrew
brew install --cask codex
```

## Authentication

### Sign in with ChatGPT account or API key

```bash
codex login
```

This opens a browser window to authenticate with your OpenAI account.

For non-browser environments:

```bash
codex login --device-auth
printenv OPENAI_API_KEY | codex login --with-api-key
```

`codex login status` exits with `0` when credentials are present, which is useful
for scripts.

## First Run

```bash
cd your-project
codex "describe what this codebase does"
```

## System Requirements

- macOS, Windows, or Linux
- npm, Homebrew, or a platform-specific GitHub release binary
- An OpenAI account (ChatGPT plan) or API key

On Windows, run natively in PowerShell with the Windows sandbox, or use WSL2
for Linux-native projects and toolchains.

## Releases & Changelog

<https://github.com/openai/codex/releases>
