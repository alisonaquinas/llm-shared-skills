# Hook Hook Scope Template

This reference supports the hook automation rule lifecycle.

Use this template to define a hook automation rule before implementation.

1. Name the hook rule and the event that should fire it.
2. Record the matcher conditions that must be true.
3. Describe the command or script the hook will invoke.
4. State whether the hook approves, blocks, logs, or rewrites behavior.
5. Document dependencies such as local binaries, credentials, or files.
6. Capture expected side effects and non-goals.
7. Define one blocked-case scenario and one recovery path.
8. Record observability needs such as logs or notifications.
9. Note portability concerns for other agent runtimes.
10. Do not leave event, matcher, or return behavior implicit.
