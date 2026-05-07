# MADR workflow

Create, review, or update Markdown Architectural Decision Records.

## Inputs

- Mode: create, review, or status-update.
- Path: ADR file or decision directory, default `docs/decisions`.
- Planning packet: title, decision question, scope, drivers, options, decision
  makers, evidence, and confirmation method.

## Create

1. Load `$madr-adr`.
2. Confirm at least one selected option and one credible alternative.
3. Generate a draft:

   ```bash
   python skills/madr-adr/scripts/new-adr.py --title "<title>"
   ```

4. Fill context, outcome, consequences, and confirmation before marking accepted.
5. Run:

   ```bash
   python skills/madr-adr/scripts/lint-adr.py docs/decisions
   ```

## Review

1. Load `$madr-adr`.
2. Run the linter against the target file or directory.
3. Report blocking structural issues first.
4. Then report evidence gaps: weak context, missing options, unclear outcome,
   one-sided consequences, stale status, or missing confirmation.

## Status Update

Update `status`, `date`, and the rationale together. Preserve ADR history;
supersede old decisions instead of rewriting accepted decisions.

## Output

Return the created path or reviewed path, lint result, findings, and next action.
