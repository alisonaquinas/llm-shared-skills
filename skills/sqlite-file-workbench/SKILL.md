---
name: sqlite-file-workbench
description: Core SQLite file operations with safe defaults for local database files. Use when tasks involve preflight tool checks, read-only querying, health checks, and creating backups from `.sqlite`/`.db` files via SQLite CLI tools, especially when command safety and reproducibility matter.
---

# SQLite File Workbench

Run safe, repeatable SQLite file operations from the command line.

## Intent Router

| Request | Reference | Load When |
|---|---|---|
| Install tool, first-time setup | `references/install-and-setup.md` | User needs to install sqlite3 or do initial configuration |

## Workflow

1. Run preflight checks before any workflow.
2. Query databases in read-only mode.
3. Run health checks before and after major changes.
4. Create backups before risky operations.
5. Hand off diff/sync/migrations/integration tasks to `$sqlite-file-workbench-advanced`.

## PATH Bootstrapping

Prefer PATH-based tool resolution.

If `sqldiff`, `sqlite3_analyzer`, or `sqlite3_rsync` are missing, add a local toolkit directory to PATH:

```bash
export PATH="/path/to/sqlite-tools:$PATH"
```

Persist this in your shell profile when needed.

## Script Interfaces

### 1) Preflight

```bash
scripts/sqlite_preflight.sh --require <tool> [--require <tool>...] [--min-sqlite-version X.Y.Z]
```

Use this to confirm CLI dependencies and minimum `sqlite3` version.

### 2) Safe Query

```bash
scripts/sqlite_safe_query.sh --db <file> (--sql <text> | --sql-file <file>) [--format table|csv|json|markdown] [--out <file>]
```

Use this for read-only querying only. The script opens databases with `-readonly`.

### 3) Health Check

```bash
scripts/sqlite_healthcheck.sh --db <file> [--analyzer] [--out-dir <dir>]
```

Use this to run quick integrity checks and optional `sqlite3_analyzer` reports.

### 4) Backup

```bash
scripts/sqlite_backup.sh --db <file> --out <backup-file> [--vacuum-into]
```

Use this before risky changes. Default mode uses `.backup`; `--vacuum-into` writes a compact backup.

## Safety Defaults

- Refuse ambiguous or unsafe invocations.
- Avoid in-place mutation in query and health workflows.
- Require explicit output paths for artifacts.
- Fail fast with actionable remediation text.

## Cross Skill Routing

Escalate to `$sqlite-file-workbench-advanced` for:

- Schema/data diff generation with `sqldiff`
- Replica synchronization with `sqlite3_rsync`
- Migration validation on cloned databases
- Python/Node integration smoke checks

## References

- `references/sqlite-doc-map.md`
- `references/core-workflows.md`
- `references/safety-and-locking.md`

## Compatibility Notes

- A local SQLite toolkit directory may be needed to access `sqldiff`, `sqlite3_analyzer`, and `sqlite3_rsync`.
- Add the toolkit location to PATH as required for your environment.

Use preflight checks to confirm runtime availability before execution.
