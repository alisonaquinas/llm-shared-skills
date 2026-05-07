# ADR Authoring Workflow

Use this reference when drafting, revising, reviewing, or changing status for a
Markdown Architectural Decision Record.

## Planning Packet

Capture these items before writing the record:

| Item | Prompt |
|---|---|
| Decision question | What architecture-significant question is being answered? |
| Scope | Which components, teams, services, or constraints are affected? |
| Drivers | Which quality attributes, deadlines, costs, risks, or policies matter? |
| Options | Which viable alternatives were considered? |
| Decision makers | Who can accept or reject the decision? |
| Evidence | Which links, benchmarks, incidents, or requirements support the choice? |
| Confirmation | How will implementation or compliance be checked? |

Proceed only when the selected option and at least one credible alternative are
named. If the selected option is still unknown, draft a `proposed` ADR with the
decision question and options, then leave the outcome explicit about uncertainty.

## Drafting Flow

1. Locate the decision directory, usually `docs/decisions`.
2. Determine the next sequence number within that directory or category.
3. Generate the draft from `scripts/new-adr.py` or the asset template.
4. Fill context before outcome. The outcome should answer the stated question.
5. Add consequences that include benefits, costs, and operational risks.
6. Add confirmation checks while the implementation plan is still fresh.
7. Run `scripts/lint-adr.py` against the created file or decision directory.

## Review Flow

Use this checklist for an existing ADR:

- One decision per record.
- Current status is clear.
- Context does not assume private conversation history.
- Options are named consistently across the options list and tradeoff sections.
- Outcome chooses one option or explicitly records rejection/deferral.
- Consequences are specific enough for future maintainers.
- Links are durable or have enough nearby explanation to survive link rot.
- Superseded or deprecated decisions point to successor ADRs when known.

## Status Changes

Treat status updates as changes to the decision log, not as casual edits.

| Transition | Expected evidence |
|---|---|
| `proposed` to `accepted` | Decision makers agreed and outcome text is final |
| `proposed` to `rejected` | Rejection reason and preferred next path are recorded |
| `accepted` to `deprecated` | Why the decision should no longer guide new work |
| `accepted` to superseded | Successor ADR is linked |

Update `date` when the status or decision text changes.

## Recovery Cases

If no decision directory exists, create `docs/decisions` unless the project has
an established architecture docs location.

If numbering conflicts exist, do not rewrite existing ADR filenames. Pick the
next unused number and record the conflict in the review notes if needed.

If the user asks to replace a prior decision, create a new ADR and mark the old
record as deprecated or superseded when project policy allows it.
