# Hook Phase Design

This reference supports the hook automation rules SDLC.

Design converts the planning packet into an explicit event contract.

1. Name events, matchers, and helper artifacts.
2. Define inputs, outputs, side effects, and failure modes.
3. Document operator-visible logs or status outputs.
4. Separate portable rule intent from runtime-specific wiring.
5. Capture all safety rules before creation begins.
6. Keep the contract stable across examples and templates.
7. Use the design skill when matcher or return decisions are unsettled.
8. A design failure is upstream of creation and integration.
9. Freeze the contract before implementation starts.
10. Revisit design whenever a new public option appears.
