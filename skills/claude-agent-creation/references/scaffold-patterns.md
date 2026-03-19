# Agent Scaffold Patterns

This reference supports the delegated agent workflow lifecycle.

Use this reference when building the actual workflow artifacts from the approved design.

1. Create the directory structure before writing content.
2. Add role files, task templates, and samples in a predictable order.
3. Keep filenames aligned with the orchestration contract.
4. Add comments only when they explain a non-obvious rule.
5. Keep helper artifacts deterministic and easy to rerun.
6. Capture a smoke-check command as soon as the files exist.
7. Avoid embedding machine-local paths in committed artifacts.
8. Keep portability notes close to runtime-specific config.
9. Treat generated files as implementation outputs, not a substitute for design.
10. Stop and revisit design if the scaffold shape needs a new interface decision.
