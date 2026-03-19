# Hook Quality Rubric

This reference supports the hook automation rule lifecycle.

Use this reference when scoring whether the rule is ready for broader reuse.

1. Discoverability: can an agent select the rule from the description alone?
2. Contract clarity: are events, matchers, and side effects explicit?
3. Safety: are risky actions guarded and observable?
4. Operability: can another engineer run and troubleshoot it?
5. Portability: are cross-runtime expectations documented honestly?
6. Examples: do examples cover the common path and one recovery path?
7. Validation evidence: is the verdict backed by test or verification notes?
8. Mark each criterion PASS, WARN, or FAIL.
9. Require safety to PASS before an APPROVE verdict.
10. Loop back immediately on any FAIL rather than hand-waving it at ship time.
