# Hook Event Contract

This reference supports the hook automation rule lifecycle.

Use this reference when designing a hook rule around an event and matcher.

1. Name the event that triggers the hook.
2. Define the matcher conditions that narrow when it runs.
3. List environment variables and payload fields the hook consumes.
4. Define the command input and expected output.
5. Specify the allowed return JSON decisions.
6. Record blocking behavior and operator override rules.
7. Define idempotency requirements for repeated events.
8. Capture logging and observability requirements.
9. Note portability expectations for runtimes without the same event model.
10. Do not ship without a written return contract.
