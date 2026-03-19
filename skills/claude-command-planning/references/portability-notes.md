# Command Portability Notes

This reference supports the reusable command workflow lifecycle.

Use this reference when the workflow must be consumable by more than one agent runtime.

1. Separate platform-neutral intent from platform-specific configuration.
2. Keep the user-facing workflow description independent of a single runtime.
3. Document runtime-only features as implementation notes, not universal requirements.
4. Identify the minimum capability needed from another runtime.
5. Prefer conceptual parity over forced 1:1 feature matching.
6. Record what stays identical across platforms: triggers, outputs, and safety rules.
7. Record what may differ: config locations, invocation syntax, or registration surfaces.
8. Keep fallback guidance explicit when a runtime lacks the native primitive.
9. Verify examples remain comprehensible without platform-specific jargon.
10. Treat portability gaps as design constraints, not post-ship surprises.
