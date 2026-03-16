# Iteration Patterns

Load this file when deciding whether to iterate, which phase to re-enter, and
how to recover from a partially completed skill development cycle.

---

## Re-Entry Decision Tree

Answer these questions in order to find the correct re-entry point:

1. **Did linting fail?** → Re-enter Phase 3. Fix FAILs → re-lint → continue.
2. **Did validation fail?** → Re-enter Phase 2 (Authoring) to fix content, then
   re-run Phase 3 and Phase 4.
3. **Did test drive expose friction?** → Re-enter Phase 2 to fix guidance, then
   Phase 3 (linting), then Phase 4 (validation).
4. **Did only WARNs appear?** → Fix WARNs in place; no phase re-entry required.

---

## Common Loop Patterns

| Failure Mode | Re-Entry Point | Phases to Skip |
|---|---|---|
| Lint FAIL (L01–L12) | Phase 3 | 1, 2 (file content unchanged) |
| Validation FAIL (V01–V07) | Phase 2 (Authoring) | 1 (ideation already done) |
| Validation FAIL (V08 only) | Phase 4 (re-score after fixes) | 1–3 (no structural change) |
| Test drive FAIL | Phase 2 (Authoring) | 1 |
| Test drive PARTIAL (fixable) | Phase 4 (re-validate after fixes) | 1–3 |
| Repeated V07 FAIL | Phase 1 (Ideation — split scope) | None; all phases need rework |

---

## Iterate-vs-Ship Decision

Ship when:

- `lint-skill.sh` exits 0 with zero FAILs
- Validation verdict is APPROVE
- Test drive has ≥3 PASS and friction report is complete
- All BLOCKED scenarios are documented

Iterate when:

- Any lint FAIL remains
- Validation is REVISE or REJECT
- Fewer than 3 test scenarios PASS
- A safety or correctness FAIL was found in test drive

---

## Partial Completion Recovery

When resuming a skill mid-cycle, inspect existing artifacts to find the highest
completed phase:

1. Does `skills/<name>/` exist? → Phase 1 (Ideation) is done.
2. Is `SKILL.md` written and `agents/` populated? → Phase 2 (Authoring) is done.
3. Did the last lint run exit 0 with zero FAILs? → Phase 3 (Linting) is done.
   **Conservative default:** if no session memory of a prior lint run exists, assume
   Phase 3 incomplete and re-run `bash linting/lint-skill.sh skills/<name>`.
4. Does a validation report exist with APPROVE verdict? → Phase 4 is done.
5. Does a friction report exist with ≥5 scenarios? → Phase 5 is done.

Start from the highest completed phase, not from Phase 1.

---

## Escalation

If V07 (LLM Usability) fails repeatedly after two full iteration cycles:

- Consider splitting the skill into two narrower skills.
- Re-enter Phase 1 (Ideation) and define tighter scope boundaries.
- A skill that attempts too much will not achieve consistent agent usability.

**Never skip Phase 3 after any authoring change.** Structural violations introduced
during iteration are the most common cause of pre-commit failures.
