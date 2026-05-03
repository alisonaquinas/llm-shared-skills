# Claude And Codex Skills Test Drive - 2026-05-03

## Summary

- **Target skills:** Claude CLI/docs, Claude command/agent/hook SDLC references,
  Codex CLI/docs, and Codex docs
- **Scenarios attempted:** 8
- **Outcome mix:** 7 passes / 1 partial corrected / 0 fails / 0 blocked
- **Final verdict:** approve after the Windows hook-shell clarification

## Scenario Outcomes

| ID | Bucket | Outcome | Score | Key evidence |
| --- | --- | --- | --- | --- |
| S01 | setup | PASS | 12 | `Get-Command` found `codex.ps1` and `claude.exe` in this Windows workspace. |
| S02 | happy-path | PASS | 11 | `codex --version` returned `codex-cli 0.120.0`; `codex --help` exposed `exec`, `login`, `mcp`, `resume`, `cloud`, `features`, `-a/--ask-for-approval`, and `-s/--sandbox`. |
| S03 | variant | PASS | 11 | `codex exec --help`, `codex mcp --help`, `codex mcp add --help`, and `codex login --help` matched the refreshed command guidance. |
| S04 | verification | PASS | 11 | Searches found no stale `--approval-mode`, `--non-interactive`, `codex auth`, `/codex/config/`, or `/codex/automation/` references in the modified Codex files. Key OpenAI Codex docs URLs returned HTTP 200. |
| S05 | happy-path | PASS | 11 | `claude --version` returned `2.1.120`; `claude --help` exposed `--bare`, `--permission-mode auto`, `--permission-mode dontAsk`, `setup-token`, `doctor`, `update`, `agents`, `auth`, and `mcp`. |
| S06 | documentation discovery | PASS | 10 | Context7 resolved Claude Code to `/websites/code_claude`; `GET` requests to `https://code.claude.com/docs/en/hooks`, `/cli-reference`, and `/claude-directory` returned HTTP 200. `HEAD` returned 404 on those routes, so liveness checks should use `GET`. |
| S07 | integration | PASS | 12 | A disposable `.claude` workspace with `agents/reviewer.md`, `commands/refresh.md`, `settings.json`, and a PowerShell hook parsed cleanly. The hook consumed stdin JSON and returned JSON with `event=PostToolUse`, `tool=Edit`, and matching `CLAUDE_PROJECT_DIR`. |
| S08 | recovery | PARTIAL, corrected | 10 | POSIX-style `$CLAUDE_PROJECT_DIR/.claude/hooks/guard.ps1` failed in both PowerShell and `cmd.exe`. After adding Windows shell syntax guidance, `pwsh -NoProfile -File "$env:CLAUDE_PROJECT_DIR/.claude/hooks/guard.ps1"` and `pwsh -NoProfile -File "%CLAUDE_PROJECT_DIR%\.claude\hooks\guard.ps1"` both returned `ok`. |

## Strengths

- Codex CLI guidance now matches the installed CLI surface, including current
  login, MCP, feature, sandbox, and approval terminology (S02, S03).
- Claude CLI guidance matches the installed CLI surface, including native
  Windows support, minimal `--bare` runs, current permission modes, health
  checks, and token setup (S05).
- The hook event-contract updates were directly usable for a live stdin JSON
  fixture and JSON stdout response (S07).
- The command, agent, and hook placement references were enough to build a
  coherent disposable `.claude` project layout without extra lookup (S07).

## Issues by Priority

### High

- None found.

### Medium

- Windows hook command syntax was under-specified before this test drive -
  evidence: S08. The initial POSIX-style `CLAUDE_PROJECT_DIR` command failed in
  both PowerShell and `cmd.exe`; the references now call out shell-specific
  expansion and include Windows-safe command examples.

### Low

- Claude docs URL probes are sensitive to HTTP method - evidence: S06. `GET`
  works for the current `code.claude.com/docs/en/...` routes, while `HEAD`
  returns 404 in this environment. Use `GET` rather than `HEAD` when verifying
  these routes.

## Improvement Actions

1. Keep the added Windows hook-shell note in `claude-cli-docs`,
   `claude-hook-design`, and `claude-hook-integration`.
2. Prefer `GET` checks for Claude docs links in future automated liveness
   testing.
3. Re-run the focused lint and validation commands before updating the PR.

## Notes

- Disposable fixture roots were created under `%TEMP%` and were not added to the
  repository.
- No authenticated Claude or Codex model calls were made; the test drive used
  local CLI help, local fixtures, local parsing, Context7 documentation
  discovery, and public documentation URL checks.
