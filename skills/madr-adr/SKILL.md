---
name: madr-adr
description: >
  Generate, author, review, and lint Markdown Architectural Decision Records
  using MADR-style structure. Use when creating a new ADR, drafting an
  architecture decision, recording accepted or proposed decisions, reviewing
  ADR quality, updating ADR status, migrating decision notes into Markdown,
  choosing ADR filenames, or checking decision records for required context,
  options, outcomes, consequences, and confirmation evidence.
---

# MADR

Workflow support for Markdown Architectural Decision Records that follow the
MADR structure.

## Intent Router

Load reference files on demand:

- `references/madr-format.md` — Load when the user asks about MADR structure,
  template sections, metadata, status values, filename patterns, categories, or
  Markdown style.
- `references/authoring-workflow.md` — Load when drafting, revising, reviewing,
  changing status, recovering from numbering conflicts, or replacing an older
  decision.
- `references/tooling-contracts.md` — Load when using or modifying helper
  scripts, plugin commands, delegated reviewer workflows, or ADR hooks.

## Quick Start

| Task | Action | Verify |
|---|---|---|
| New ADR | Generate a draft with `scripts/new-adr.py` | Run `scripts/lint-adr.py` |
| Review ADR | Check structure, evidence, and status | Report findings before edits |
| Status update | Update `status`, `date`, and rationale | Link successor ADRs when needed |
| Migration | Convert notes into MADR sections | Preserve evidence and authorship |

## Draft A New ADR

Start from a planning packet: decision question, scope, drivers, options,
decision makers, evidence, and confirmation method.

Use the helper script when writing a file:

```bash
python skills/madr-adr/scripts/new-adr.py \
  --title "Use PostgreSQL for event storage" \
  --dir docs/decisions \
  --driver "Durable audit history" \
  --driver "Operational familiarity" \
  --option "PostgreSQL" \
  --option "EventStoreDB"
```

Then replace `TBD` placeholders with project-specific evidence. Keep the
decision outcome aligned with the question stated in Context and Problem
Statement.

## Review An ADR

Run the structural checker first:

```bash
python skills/madr-adr/scripts/lint-adr.py docs/decisions
```

Review quality manually:

- One decision per record.
- Status is accurate and dated.
- Context states the architectural force or constraint.
- Options include credible alternatives.
- Outcome says why the selected option wins.
- Consequences include costs and risks.
- Confirmation explains how compliance will be checked.

## Update Status

Status changes require evidence. Update `date` whenever status or decision text
changes. When an ADR is superseded, link the successor ADR instead of deleting
or rewriting history.

Common status values:

| Status | Meaning |
|---|---|
| `proposed` | Under discussion |
| `accepted` | Decision has authority |
| `rejected` | Option or proposal was not adopted |
| `deprecated` | No longer recommended for new work |
| `superseded by ADR-NNNN` | Replaced by a later decision |

## Safety Rules

Do not invent agreement, decision makers, benchmark results, incident links, or
policy requirements. Mark unknown material as `TBD` in drafts or ask for the
missing evidence.

Do not renumber existing ADRs to make a sequence tidy. Pick the next unused
number and preserve decision-log history.

Do not edit an accepted ADR to reverse the decision. Create a new ADR and mark
the earlier record deprecated or superseded when appropriate.

## Scripts

- `scripts/new-adr.py` — Create a numbered MADR-style draft.
- `scripts/lint-adr.py` — Check ADR files or directories for structural issues.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/madr-format.md` | MADR structure, metadata, status, filenames |
| `references/authoring-workflow.md` | Drafting, review, status changes, recovery |
| `references/tooling-contracts.md` | Scripts, command workflow, reviewer, hook |
