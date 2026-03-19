# Hook Re Entry Patterns

This reference supports the hook automation rule lifecycle.

Use this reference when a rule gate fails and the next step is unclear.

1. Start from the earliest phase that can change the failed outcome.
2. Planning failures re-enter planning.
3. Contract failures re-enter design.
4. Runtime defects or missing files re-enter creation.
5. Coverage gaps re-enter testing.
6. Contract drift re-enters verification before integration is retried.
7. Discovery failures re-enter integration unless the contract changed.
8. Rubric failures re-enter validation only when no upstream artifact needs edits.
9. Keep a written record of which gate failed and why.
10. Re-run the failed gate after every relevant fix before moving forward.
