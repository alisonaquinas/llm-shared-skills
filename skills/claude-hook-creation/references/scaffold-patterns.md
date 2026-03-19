# Hook Scaffold Patterns

This reference supports the hook automation rule lifecycle.

Use this reference when building the actual rule artifacts from the approved design.

1. Create the directory structure before writing content.
2. Add config files, helper scripts, and samples in a predictable order.
3. Keep filenames aligned with the event contract.
4. Add comments only when they explain a non-obvious rule.
5. Keep helper scripts deterministic and easy to rerun.
6. Capture a smoke-check command as soon as the files exist.
7. Avoid embedding machine-local paths in committed artifacts.
8. Keep portability notes close to the runtime-specific config.
9. Treat generated files as implementation outputs, not a substitute for design.
10. Stop and revisit design if the scaffold shape needs a new interface decision.
