# Hook Portability Notes

This reference supports the hook automation rule lifecycle.

Use this reference when the rule must be consumable by more than one agent runtime.

1. Separate platform-neutral intent from platform-specific configuration.
2. Keep the operator-facing rule description independent of a single runtime.
3. Document runtime-only features as implementation notes, not universal requirements.
4. Identify the minimum capability needed from another runtime.
5. Prefer conceptual parity over forced 1:1 feature matching.
6. Record what stays identical across platforms: event intent, safety rules, and outputs.
7. Record what may differ: hook registration, env vars, or settings paths.
8. Keep fallback guidance explicit when a runtime lacks the native primitive.
9. Verify examples remain comprehensible without platform-specific jargon.
10. Treat portability gaps as design constraints, not post-ship surprises.
