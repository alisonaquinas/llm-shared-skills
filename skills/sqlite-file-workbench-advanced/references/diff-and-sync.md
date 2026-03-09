# Diff and Sync Guide

## Diff Workflow (`sqldiff`)

Generate full SQL transform:

```bash
scripts/sqlite_diff.sh --from old.db --to new.db --out artifacts/full-diff.sql
```

Schema-only diff:

```bash
scripts/sqlite_diff.sh --from old.db --to new.db --schema-only
```

Summary only:

```bash
scripts/sqlite_diff.sh --from old.db --to new.db --summary
```

Single-table diff:

```bash
scripts/sqlite_diff.sh --from old.db --to new.db --table users
```

Reference: https://www.sqlite.org/sqldiff.html

## Sync Workflow (`sqlite3_rsync`)

Preview command (default dry-run):

```bash
scripts/sqlite_sync.sh --origin prod.db --replica deploy@host:/srv/prod.db
```

Apply sync:

```bash
scripts/sqlite_sync.sh --origin prod.db --replica deploy@host:/srv/prod.db --apply
```

Use WAL-only constraint:

```bash
scripts/sqlite_sync.sh --origin prod.db --replica deploy@host:/srv/prod.db --wal-only --apply
```

Reference: https://www.sqlite.org/rsync.html

## Safety Notes
- Review generated diffs before applying downstream.
- Keep sync in preview mode until host and path are validated.
- Prefer maintenance windows for high-volume replica syncs.
