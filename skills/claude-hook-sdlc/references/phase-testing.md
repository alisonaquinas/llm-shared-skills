# Hook Phase Testing

This reference supports the hook automation rules SDLC.

Testing collects evidence that the rule behaves correctly before integration.

1. Exercise the happy path and one meaningful variant.
2. Exercise one blocked path and one recovery path.
3. Keep fixtures disposable and deterministic.
4. Record expected outputs and observed results.
5. Prefer dry runs when the rule can mutate state.
6. Capture blocked dependencies instead of hiding them.
7. Use the testing skill to build the scenario matrix.
8. Keep the test matrix aligned with the design contract.
9. A rule without negative-path evidence is not ready for verification.
10. Testing evidence should be short but concrete.
