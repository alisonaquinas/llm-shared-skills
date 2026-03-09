---
name: sqlite
description: Complete SQLite file operations spanning core read-only queries, backups, health checks, and advanced workflows including database diffing, replica sync, migrations, and application integration. Use for any SQLite-related task from simple querying to complex multi-database operations.
---

# SQLite

Safe, repeatable SQLite file operations from preflight checks through advanced workflows.

## Intent Router

| Request | Reference | Load When |
| --- | --- | --- |
| Install tool, first-time setup | `references/install-and-setup.md` | User needs to install sqlite3, sqldiff, sqlite3_rsync, or do initial configuration |
| Read-only queries, health checks, backups | `references/core-workflows.md` | User needs basic database operations and safe defaults |
| Schema/data diffing, database sync, migrations | `references/diff-and-sync.md` | User needs to compare schemas, synchronize replicas, or validate migrations |
| Python/Node integration, smoke tests | `references/integration-python-node.md` | User needs to verify database behavior in application code |
| Migration validation and planning | `references/migrations.md` | User needs to validate migration scripts on cloned databases |
| SQL patterns, query strategies | `references/sql-patterns.md` | User needs complex query help or optimization guidance |
| Safety, locking, concurrency | `references/safety-and-locking.md` | User needs to understand locking, transactions, and safe concurrent access |
| SQLite documentation reference | `references/sqlite-doc-map.md` | User needs quick links to official SQLite documentation |

## Workflow

1. Run preflight checks before any workflow.
2. Query databases in read-only mode.
3. Run health checks before and after major changes.
4. Create backups before risky operations.
5. Use advanced features (diff, sync, migrations, integration) with explicit guardrails.

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

## All Available References

- `references/core-workflows.md` — Basic queries, backups, health checks
- `references/diff-and-sync.md` — Database diffing and replica synchronization
- `references/integration-python-node.md` — Application-level integration testing
- `references/migrations.md` — Migration validation and verification
- `references/safety-and-locking.md` — Transactions, locks, and concurrent access
- `references/sql-patterns.md` — Query patterns and optimization
- `references/sqlite-doc-map.md` — Official SQLite documentation reference
- `references/install-and-setup.md` — Installation and toolkit setup

## Compatibility Notes

- A local SQLite toolkit directory may be needed to access `sqldiff`, `sqlite3_analyzer`, and `sqlite3_rsync`.
- Add the toolkit location to PATH as required for your environment.

Use preflight checks to confirm runtime availability before execution.
