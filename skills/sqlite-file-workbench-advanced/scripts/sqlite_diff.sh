#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  sqlite_diff.sh --from <db1> --to <db2> [--schema-only] [--summary] [--table <name>] [--out <file>]

Options:
  --from <db1>      Source database
  --to <db2>        Target database
  --schema-only     Emit schema differences only
  --summary         Emit summary only
  --table <name>    Diff a single table
  --out <file>      Write output to file (refuses overwrite)
  -h, --help        Show this help
USAGE
}

from_db=""
to_db=""
schema_only=0
summary_only=0
table_name=""
out_file=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --from)
      [[ $# -ge 2 ]] || { echo "[ERROR] --from needs a value" >&2; usage; exit 1; }
      from_db="$2"
      shift 2
      ;;
    --to)
      [[ $# -ge 2 ]] || { echo "[ERROR] --to needs a value" >&2; usage; exit 1; }
      to_db="$2"
      shift 2
      ;;
    --schema-only)
      schema_only=1
      shift
      ;;
    --summary)
      summary_only=1
      shift
      ;;
    --table)
      [[ $# -ge 2 ]] || { echo "[ERROR] --table needs a value" >&2; usage; exit 1; }
      table_name="$2"
      shift 2
      ;;
    --out)
      [[ $# -ge 2 ]] || { echo "[ERROR] --out needs a value" >&2; usage; exit 1; }
      out_file="$2"
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

[[ -n "$from_db" ]] || { echo "[ERROR] --from is required" >&2; usage; exit 1; }
[[ -n "$to_db" ]] || { echo "[ERROR] --to is required" >&2; usage; exit 1; }
[[ -f "$from_db" ]] || { echo "[ERROR] Source DB not found: $from_db" >&2; exit 1; }
[[ -f "$to_db" ]] || { echo "[ERROR] Target DB not found: $to_db" >&2; exit 1; }

if ! command -v sqldiff >/dev/null 2>&1; then
  echo "[ERROR] sqldiff not found on PATH" >&2
  echo "[HINT] export PATH=\"<path-to-sqlite-toolkit>:\$PATH\"" >&2
  exit 1
fi

if [[ -n "$out_file" && -e "$out_file" ]]; then
  echo "[ERROR] Refusing to overwrite existing output file: $out_file" >&2
  exit 1
fi

if [[ -n "$out_file" ]]; then
  mkdir -p "$(dirname "$out_file")"
fi

cmd=(sqldiff)
[[ "$schema_only" -eq 1 ]] && cmd+=(--schema)
[[ "$summary_only" -eq 1 ]] && cmd+=(--summary)
[[ -n "$table_name" ]] && cmd+=(--table "$table_name")
cmd+=("$from_db" "$to_db")

printf '[INFO] Running:'
printf ' %q' "${cmd[@]}"
printf '\n'

if [[ -n "$out_file" ]]; then
  "${cmd[@]}" > "$out_file"
  echo "[OK] Diff output written to $out_file"
else
  "${cmd[@]}"
fi
