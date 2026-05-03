# Hook Event Contract

This reference supports the hook automation rule lifecycle.

Use this reference when designing a hook rule around an event and matcher.

1. Name the event that triggers the hook.
2. Define the matcher conditions that narrow when it runs.
3. List stdin JSON payload fields the hook consumes.
4. Define the command input and expected output.
5. Specify the allowed exit-code and return-JSON decisions.
6. Record blocking behavior and operator override rules.
7. Define idempotency requirements for repeated events.
8. Capture logging and observability requirements.
9. Note portability expectations for runtimes without the same event model.
10. Do not ship without a written return contract.

## Claude Code Event Shape

Current hook commands receive the event payload as JSON on stdin. Do not assume
tool details are exposed as individual environment variables. `CLAUDE_PROJECT_DIR`
is available when the CLI spawns the hook and should be used for project-relative
scripts. Express that variable using the target shell's syntax, such as
`$env:CLAUDE_PROJECT_DIR` in PowerShell or `%CLAUDE_PROJECT_DIR%` in `cmd.exe`.

## Common Events

| Event | Matcher? | Typical use |
| --- | --- | --- |
| `PreToolUse` | Yes | Block or approve a specific tool call before it runs |
| `PostToolUse` | Yes | Inspect output after a tool call |
| `UserPromptSubmit` | No | Validate or enrich the user's prompt before processing |
| `Notification` | No | Notify an operator |
| `Stop` | No | Require additional work before the main agent stops |
| `SubagentStop` | No | Require additional work before a subagent stops |
| `PreCompact` | No | Prepare for transcript compaction |
| `SessionStart` | No | Add startup context |
| `SessionEnd` | No | Run cleanup; cannot block termination |

## Return Contract

Record both paths:

- Exit code `0`: success. stdout is user-visible or context-injected only for
  documented events.
- Exit code `2`: blocking error. stderr is fed back according to event behavior.
- Other non-zero exit: non-blocking error; stderr is shown to the user.
- JSON stdout: may include `continue`, `stopReason`, `suppressOutput`,
  `systemMessage`, or event-specific fields such as `decision` and `reason`.

Timeout defaults to 60 seconds per hook command unless configured otherwise.
Matching hook commands run in parallel, so scripts must be safe under concurrent
execution or explicitly serialize their own writes.
