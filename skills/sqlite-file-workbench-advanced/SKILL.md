---
name: sqlite-file-workbench-advanced
description: Advanced SQLite workflows for diffing databases, syncing replicas, validating migrations on cloned files, and running Python/Node integration smoke tests. Use when tasks exceed core read-only query/backup flows and require `sqldiff`, `sqlite3_rsync`, or application-level verification.
---

# SQLite File Workbench Advanced

Run advanced SQLite workflows with explicit guardrails.

## Workflow
1. Run `scripts/sqlite_preflight.sh` from `$sqlite-file-workbench` to verify tools and versions.
2. Generate diffs before migration or synchronization work.
3. Keep sync commands dry-run by default and require explicit `--apply` for execution.
4. Validate migrations on cloned databases, never production files.
5. Run integration smoke checks to verify runtime access paths.

## Script Interfaces

### 1) Diff
```bash
scripts/sqlite_diff.sh --from <db1> --to <db2> [--schema-only] [--summary] [--table <name>] [--out <file>]
```
Use this to generate SQL transforms or summaries with `sqldiff`.

### 2) Sync
```bash
scripts/sqlite_sync.sh --origin <path-or-user@host:path> --replica <path-or-user@host:path> [--wal-only] [--ssh <path>] [--exe <path>] [--apply]
```
Use this for replica synchronization with `sqlite3_rsync`. Omit `--apply` for preview mode.

### 3) Migration Validation
```bash
scripts/sqlite_migration_validate.sh --db <file> --migration <sql-file> [--seed <sql-file>] [--out-dir <dir>]
```
Use this to test migrations on copied databases with integrity checks.

### 4) Integration Smoke
```bash
scripts/sqlite_integration_smoke.sh --db <file> [--python] [--node]
```
Use this to verify language runtime connectivity and simple read-only queries.

## Safety Defaults
- Keep sync in dry-run mode unless `--apply` is present.
- Refuse overwrite for generated artifacts.
- Clone source DBs before applying migrations.
- Return clear failure text for missing PATH tools.

## Cross Skill Routing
Use `$sqlite-file-workbench` first for:
- PATH and version preflight
- Read-only querying
- Health checks and analyzer reports
- Backup creation

## References
- `references/diff-and-sync.md`
- `references/migrations.md`
- `references/integration-python-node.md`

## Compatibility Notes
- A local SQLite toolkit directory may be needed to access `sqldiff`, `sqlite3_analyzer`, and `sqlite3_rsync`.
- Add the toolkit location to PATH as required for your environment (e.g., `export PATH="/path/to/sqlite-tools:$PATH"`).
