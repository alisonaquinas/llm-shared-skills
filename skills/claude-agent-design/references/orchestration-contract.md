# Agent Orchestration Contract

This reference supports the delegated agent workflow lifecycle.

Use this reference when designing a delegated agent workflow.

1. Name each role and its scope of ownership.
2. Define the orchestrator responsibilities separately from worker responsibilities.
3. Record inputs each role receives and outputs it must return.
4. Define message or handoff structure in plain terms.
5. Specify merge rules when work overlaps.
6. Record cancellation or escalation behavior.
7. Define isolation expectations and shared-state constraints.
8. Capture fallback behavior when one role is blocked.
9. Note portability expectations across runtimes with different delegation tools.
10. Freeze the handoff contract before creation begins.
