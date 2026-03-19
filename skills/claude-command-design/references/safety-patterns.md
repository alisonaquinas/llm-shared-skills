# Command Safety Patterns

This reference supports the reusable command workflow lifecycle.

Use this reference when the workflow can mutate files, approve actions, or coordinate risky behavior.

1. Name the risky action explicitly.
2. Require a clear precondition or guardrail before that action runs.
3. Document a safe alternative when the risky path is avoidable.
4. Keep destructive behavior behind a deliberate decision point.
5. Capture rollback steps where possible.
6. Prefer idempotent actions for automations that may rerun.
7. Surface operator-visible logging for blocked or approved actions.
8. Avoid hidden side effects not reflected in the design contract.
9. Treat portability gaps as safety risks when behavior differs by runtime.
10. Revisit this checklist whenever the workflow gains new write or approval powers.
