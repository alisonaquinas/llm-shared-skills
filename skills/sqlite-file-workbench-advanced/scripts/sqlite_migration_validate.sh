#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  sqlite_migration_validate.sh --db <file> --migration <sql-file> [--seed <sql-file>] [--out-dir <dir>]

Options:
  --db <file>          Source database file (never modified)
  --migration <file>   Migration SQL file to validate
  --seed <file>        Optional SQL seed file applied before migration
  --out-dir <dir>      Keep artifacts in this directory
  -h, --help           Show this help

Safety:
  Validation runs on a copied database in an artifact directory.
USAGE
}

db_path=""
migration_file=""
seed_file=""
out_dir=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --db)
      [[ $# -ge 2 ]] || { echo "[ERROR] --db needs a value" >&2; usage; exit 1; }
      db_path="$2"
      shift 2
      ;;
    --migration)
      [[ $# -ge 2 ]] || { echo "[ERROR] --migration needs a value" >&2; usage; exit 1; }
      migration_file="$2"
      shift 2
      ;;
    --seed)
      [[ $# -ge 2 ]] || { echo "[ERROR] --seed needs a value" >&2; usage; exit 1; }
      seed_file="$2"
      shift 2
      ;;
    --out-dir)
      [[ $# -ge 2 ]] || { echo "[ERROR] --out-dir needs a value" >&2; usage; exit 1; }
      out_dir="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "[ERROR] Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

[[ -n "$db_path" ]] || { echo "[ERROR] --db is required" >&2; usage; exit 1; }
[[ -n "$migration_file" ]] || { echo "[ERROR] --migration is required" >&2; usage; exit 1; }
[[ -f "$db_path" ]] || { echo "[ERROR] Database file not found: $db_path" >&2; exit 1; }
[[ -f "$migration_file" ]] || { echo "[ERROR] Migration SQL file not found: $migration_file" >&2; exit 1; }
if [[ -n "$seed_file" ]]; then
  [[ -f "$seed_file" ]] || { echo "[ERROR] Seed SQL file not found: $seed_file" >&2; exit 1; }
fi

if [[ -n "$out_dir" ]]; then
  mkdir -p "$out_dir"
  artifact_dir="$out_dir"
else
  artifact_dir="$(mktemp -d /tmp/sqlite-migration-validate.XXXXXX)"
fi

tmp_db="$artifact_dir/migration-validate.sqlite"
log_file="$artifact_dir/migration.log"

cp "$db_path" "$tmp_db"

echo "[INFO] Artifact directory: $artifact_dir"
echo "[INFO] Working database copy: $tmp_db"

if [[ -n "$seed_file" ]]; then
  echo "[INFO] Applying seed SQL: $seed_file"
  if ! sqlite3 -bail "$tmp_db" < "$seed_file" > "$log_file" 2>&1; then
    echo "[ERROR] Seed SQL failed. See log: $log_file" >&2
    tail -n 40 "$log_file" >&2 || true
    exit 1
  fi
fi

echo "[INFO] Applying migration SQL: $migration_file"
if ! sqlite3 -bail "$tmp_db" < "$migration_file" >> "$log_file" 2>&1; then
  echo "[ERROR] Migration SQL failed. See log: $log_file" >&2
  tail -n 40 "$log_file" >&2 || true
  exit 1
fi

quick_check="$(sqlite3 -readonly "$tmp_db" "PRAGMA quick_check;" | head -n1)"
integrity_check="$(sqlite3 -readonly "$tmp_db" "PRAGMA integrity_check;" | head -n1)"
fk_violations="$(sqlite3 -readonly "$tmp_db" "SELECT count(*) FROM pragma_foreign_key_check;" | tr -d '[:space:]')"

{
  echo "quick_check=$quick_check"
  echo "integrity_check=$integrity_check"
  echo "foreign_key_violations=$fk_violations"
} >> "$log_file"

if [[ "$quick_check" != "ok" || "$integrity_check" != "ok" || "$fk_violations" != "0" ]]; then
  echo "[ERROR] Migration validation checks failed" >&2
  echo "[ERROR] quick_check=$quick_check integrity_check=$integrity_check fk=$fk_violations" >&2
  echo "[ERROR] See log: $log_file" >&2
  exit 1
fi

echo "[OK] Migration validation passed"
echo "[OK] quick_check=$quick_check"
echo "[OK] integrity_check=$integrity_check"
echo "[OK] foreign_key_violations=$fk_violations"
echo "[OK] Log file: $log_file"
