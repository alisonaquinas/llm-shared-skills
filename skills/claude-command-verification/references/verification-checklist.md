# Command Verification Checklist

This reference supports the reusable command workflow lifecycle.

Use this reference after testing and before integration.

1. Confirm the implementation still matches the design contract.
2. Confirm all required files and scripts are present.
3. Confirm defaults and optional inputs are documented.
4. Confirm the fallback path is written and reachable.
5. Confirm safety guardrails remain in place.
6. Confirm smoke checks use the committed artifact names.
7. Confirm portability notes are still accurate.
8. Confirm operator-visible logs or outputs exist where needed.
9. Confirm no stale TODO or TBD markers remain.
10. Treat every failed checklist item as an upstream issue to fix before integration.
