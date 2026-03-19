# Agent Phase Integration

This reference supports the delegated agent workflows SDLC.

Integration places the workflow in the runtime and proves it is discoverable.

1. Wire the workflow into the expected discovery path or settings file.
2. Confirm the runtime lists or loads it.
3. Run one live invocation.
4. Capture runtime-specific caveats in the integration notes.
5. Keep shared and project-local integration paths separate.
6. Use the integration skill for placement and troubleshooting.
7. A workflow is not integrated until discovery and invocation both succeed.
8. Preserve a rollback path for bad registrations.
9. Avoid machine-local assumptions other users cannot reproduce.
10. Integration evidence should be easy to reproduce.
