# Agent Test Harness

This reference supports the delegated agent workflow lifecycle.

Use this reference when preparing tests for the workflow before integration.

1. Start with a happy-path fixture that exercises the intended contract.
2. Add at least one variant with a meaningful role-split change.
3. Add a blocked case that proves the workflow reports escalation clearly.
4. Add a recovery case that exercises retry or fallback logic.
5. Keep fixtures small, deterministic, and disposable.
6. Capture expected logs, files, or return values for each scenario.
7. Note any external dependency that cannot be simulated locally.
8. Prefer dry runs when the workflow can mutate state.
9. Keep test names aligned with the design contract.
10. Do not advance without evidence for both success and blocked behavior.
