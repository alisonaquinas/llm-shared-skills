# Codex CLI — Command Reference

## Reference Page

<https://developers.openai.com/codex/cli/reference>

## Basic Usage

```bash
codex                           # start interactive session
codex "describe the codebase"   # one-shot task
codex exec "..."                # non-interactive automation
```

## Key Flags

| Flag | Description |
| --- | --- |
| `--ask-for-approval`, `-a` | Approval policy: `untrusted`, `on-request`, `never` |
| `--sandbox`, `-s` | Shell sandbox: `read-only`, `workspace-write`, `danger-full-access` |
| `--model`, `-m` | Override model (for example `gpt-5.4`) |
| `--config`, `-c` | Override a config value as `key=value` for this invocation |
| `--profile`, `-p` | Load a named profile from `~/.codex/config.toml` |
| `--cd`, `-C` | Set working directory |
| `--add-dir` | Add another writable directory |
| `--image`, `-i` | Attach image input paths to the initial prompt |
| `--search` | Enable live web search for the session |
| `--yolo` | Bypass approvals and sandbox; use only inside an external sandbox |

## Approval & Sandbox

| Control | Description |
| --- | --- |
| `-a on-request -s workspace-write` | Balanced interactive editing |
| `-a never -s workspace-write` | Unattended run inside the workspace sandbox |
| `-a untrusted -s read-only` | Conservative exploration/review |
| `--yolo` | No approval or sandbox protection |

## Pipe Usage

```bash
# Pipe a file for analysis
cat error.log | codex exec "what is causing these errors?"

# Pipe git diff for review
git diff | codex exec "review these changes for issues"
```

## Common Subcommands

```bash
codex login                         # browser sign-in
codex login --device-auth           # device-code sign-in
printenv OPENAI_API_KEY | codex login --with-api-key
codex login status                  # check current auth state
codex logout                        # sign out

codex exec "task"                   # non-interactive task
codex resume --last                 # resume most recent session
codex resume <session-id>           # resume by ID

codex mcp add docs -- npx -y @modelcontextprotocol/server-filesystem .
codex mcp add remote --url https://mcp.example.com/mcp
codex mcp list --json
codex mcp remove docs

codex mcp-server                    # expose Codex as an MCP server over stdio
```

Full reference: <https://developers.openai.com/codex/cli/reference>
