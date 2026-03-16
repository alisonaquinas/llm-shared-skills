# Phase 4: Validation

Deep guidance for the validation phase. Load when scoring a skill against the
8-criterion rubric or interpreting validation output.

---

## Pre-Flight Command

Generate automated context for qualitative review:

```bash
bash validation/validate-skill.sh skills/<name>
```

Output includes: line count, section count, reference file list, example count,
and estimated coverage percentage.

---

## Scoring Workflow

1. Run the pre-flight command and note the automated metrics.
2. Load `validation/rubric.md`.
3. Score each criterion V01–V08 as PASS, WARN, or FAIL.
4. Record rationale for each score (1–2 sentences).
5. Apply decision thresholds to determine the overall verdict.

---

## 8-Criterion Table

| ID | Criterion | PASS Condition | WARN Condition | FAIL Condition | Typical Fix |
|---|---|---|---|---|---|
| V01 | Description effectiveness | All 4 trigger elements present and specific | Generic triggers; missing context | No triggers or extremely vague | Add 3+ specific trigger phrases and scenarios |
| V02 | Intent Router completeness | All refs listed with specific load conditions | Vague conditions; some refs missing | No Intent Router or dangling refs | Add explicit per-ref load conditions |
| V03 | Quick Reference coverage | ~80% of requests covered inline | 50–80% coverage; some gaps | <50% coverage; major workflows missing | Inline common workflows in SKILL.md |
| V04 | Safety coverage | All destructive ops documented with guardrails | Some ops covered; inconsistent guards | Dangerous ops unguarded or undocumented | Add what-could-go-wrong + recovery steps |
| V05 | Example quality | Concrete, runnable; happy path + edge cases | Some examples vague or missing edges | No examples or pseudocode only | Add 2–3 runnable examples per workflow |
| V06 | Reference file depth | Self-contained; sufficient to execute without SKILL.md | Minor hand-waving; small gaps | Refers back to SKILL.md for essentials | Expand until each reference needs no external deps |
| V07 | LLM usability | Agent succeeds reliably; no ambiguity | Occasional confusion; minor gaps | Frequent failure or contradictions | Rewrite ambiguous instructions in imperative form |
| V08 | Public docs alignment | 6+ of 8 prompt-engineering standards met | 4–5 standards met | <4 standards met | Check the 8 standards table below |

### V08: 8 Prompt-Engineering Standards Checklist

Score PASS if 6 or more are met:

| # | Standard | Check |
|---|---|---|
| 1 | Specificity over generality | Descriptions are concrete, not just topic names |
| 2 | Concrete, diverse examples | 2–3 runnable examples per workflow; edge cases shown |
| 3 | Step-by-step workflows | Numbered, atomic steps rather than prose paragraphs |
| 4 | Verification steps | Each step has an observable check for success |
| 5 | Explicit failure modes | Errors and recovery documented, not assumed |
| 6 | Single responsibility | Skill has clear scope; does not try to cover everything |
| 7 | Specify output format | Expected output or success indicator is shown |
| 8 | Context window efficiency | Critical info first; detailed docs lazy-loaded to references |

---

## Decision Thresholds

| Verdict | Condition |
|---|---|
| **APPROVE** | ≥7 criteria at PASS; ≤1 at FAIL; all V01–V07 PASS or WARN; V08 PASS |
| **REVISE** | 3–6 criteria at PASS; 1–3 at FAIL (fixable issues); resubmit after fixes |
| **REJECT** | <3 criteria at PASS; ≥3 at FAIL; fundamental rework needed |

---

## Report Template

```markdown
# Skill Validation Report: <name>

## Automated Checks

- Line count: N
- Reference files: N
- Examples: N

## Qualitative Scoring

| Criterion | Score | Rationale |
|---|---|---|
| V01: Description | PASS/WARN/FAIL | [reason] |
| V02: Intent Router | PASS/WARN/FAIL | [reason] |
| V03: Quick Ref | PASS/WARN/FAIL | [reason] |
| V04: Safety | PASS/WARN/FAIL | [reason] |
| V05: Examples | PASS/WARN/FAIL | [reason] |
| V06: References | PASS/WARN/FAIL | [reason] |
| V07: Usability | PASS/WARN/FAIL | [reason] |
| V08: Public Docs | PASS/WARN/FAIL | [reason] |

## Summary

**Overall:** APPROVE / REVISE / REJECT

**Strengths:** [up to 3 things done well]

**Issues:** [FAIL items with fixes; WARN items to address]
```

---

## Gate Criterion

Validation phase is complete when:

- Overall verdict is APPROVE
- All V01–V07 scored PASS or WARN
- V08 scored PASS
- Validation report written and retained for reference
