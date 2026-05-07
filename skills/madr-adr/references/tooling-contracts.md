# ADR Tooling Contracts

This reference defines the local helper scripts and plugin-level workflow
artifacts that support MADR authoring.

## Skill Scripts

### `scripts/new-adr.py`

Creates a new MADR-style Markdown file.

Inputs:

- `--title` is required and becomes the H1 and filename slug.
- `--dir` defaults to `docs/decisions`.
- `--status` defaults to `proposed`.
- `--template` accepts `full` or `minimal`.
- `--driver`, `--option`, `--decision-makers`, `--consulted`, and `--informed`
  add draft content.
- `--dry-run` prints the target path and content without writing.

Outputs:

- Creates the decision directory if missing.
- Writes `NNNN-title-with-dashes.md`.
- Refuses to overwrite an existing file.

### `scripts/lint-adr.py`

Checks one ADR file or a directory tree of ADR files.

Checks:

- Filename follows the four-digit dashed pattern.
- Required MADR sections exist.
- Exactly one H1 exists.
- Considered options are present.
- Decision outcome includes a chosen option or explicit rejected/deferred text.
- Template placeholders are not left in final records.

Use `--strict` to treat warnings as failures.

## Command Workflow

`commands/adr-workflow.md` is a reusable command guide for creating or reviewing
ADRs. It keeps the public interface simple:

- create a new ADR from a title and planning packet
- review an existing ADR
- update status with evidence

The command should call the `madr-adr` skill and use the scripts when a
workspace file needs to be generated or checked.

## Delegated Agent Workflow

`agents/adr-reviewer.md` defines a reviewer role for ADR quality checks. The
agent reads the target ADR and reports findings before edits are made. It does
not make architecture decisions on behalf of a team.

## Hook Workflow

`hooks/adr-lint` is a lightweight helper for hook contexts. It reads event JSON
from stdin, looks for edited Markdown files under a `decisions` path, and runs
the ADR lint script when available.

The hook is intentionally best-effort:

- no output when no ADR files are involved
- no hard failure when Python is unavailable
- no repository writes
- nonzero exit only when an ADR lint check finds a structural error

On Windows, invoke the hook through `hooks/run-hook.cmd adr-lint`. Passing a
Windows absolute path directly to `bash` can strip backslashes before the script
starts.
