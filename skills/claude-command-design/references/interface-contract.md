# Command Interface Contract

This reference supports the reusable command workflow lifecycle.

Use this reference when designing the public contract for the workflow.

1. Name every public entry point before writing implementation files.
2. Define required inputs, optional inputs, and defaults.
3. Define output shape, side effects, and completion criteria.
4. Record preconditions and assumptions.
5. Document failure signals and retry guidance.
6. Keep naming consistent across docs, configs, and templates.
7. Distinguish user-facing labels from internal helper names.
8. Note portability expectations for alternate runtimes.
9. Validate that the contract can be tested without hidden state.
10. Freeze the contract before moving to creation.
