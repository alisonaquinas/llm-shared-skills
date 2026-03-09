#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  sqlite_sync.sh --origin <path-or-user@host:path> --replica <path-or-user@host:path> [--wal-only] [--ssh <path>] [--exe <path>] [--apply]

Options:
  --origin <value>   Origin database endpoint
  --replica <value>  Replica database endpoint
  --wal-only         Pass --wal-only to sqlite3_rsync
  --ssh <path>       Path to SSH executable
  --exe <path>       Path to sqlite3_rsync on remote side
  --apply            Execute sync (default is dry-run preview)
  -h, --help         Show this help

Safety:
  Without --apply, this script prints the command and exits without syncing.
USAGE
}

is_remote_endpoint() {
  [[ "$1" == *@*:* ]]
}

origin=""
replica=""
wal_only=0
ssh_path=""
exe_path=""
apply=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --origin)
      [[ $# -ge 2 ]] || { echo "[ERROR] --origin needs a value" >&2; usage; exit 1; }
      origin="$2"
      shift 2
      ;;
    --replica)
      [[ $# -ge 2 ]] || { echo "[ERROR] --replica needs a value" >&2; usage; exit 1; }
      replica="$2"
      shift 2
      ;;
    --wal-only)
      wal_only=1
      shift
      ;;
    --ssh)
      [[ $# -ge 2 ]] || { echo "[ERROR] --ssh needs a value" >&2; usage; exit 1; }
      ssh_path="$2"
      shift 2
      ;;
    --exe)
      [[ $# -ge 2 ]] || { echo "[ERROR] --exe needs a value" >&2; usage; exit 1; }
      exe_path="$2"
      shift 2
      ;;
    --apply)
      apply=1
      shift
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

[[ -n "$origin" ]] || { echo "[ERROR] --origin is required" >&2; usage; exit 1; }
[[ -n "$replica" ]] || { echo "[ERROR] --replica is required" >&2; usage; exit 1; }

if ! command -v sqlite3_rsync >/dev/null 2>&1; then
  echo "[ERROR] sqlite3_rsync not found on PATH" >&2
  echo "[HINT] export PATH=\"/Users/allisonaquinas/SQLite-tools:\$PATH\"" >&2
  exit 1
fi

origin_remote=0
replica_remote=0
is_remote_endpoint "$origin" && origin_remote=1
is_remote_endpoint "$replica" && replica_remote=1

if [[ "$origin_remote" -eq "$replica_remote" ]]; then
  echo "[WARN] Expected exactly one remote endpoint in USER@HOST:PATH format" >&2
  echo "[WARN] Continuing anyway; sqlite3_rsync will validate endpoints." >&2
fi

cmd=(sqlite3_rsync "$origin" "$replica")
[[ "$wal_only" -eq 1 ]] && cmd+=(--wal-only)
[[ -n "$ssh_path" ]] && cmd+=(--ssh "$ssh_path")
[[ -n "$exe_path" ]] && cmd+=(--exe "$exe_path")

printf '[INFO] Command:'
printf ' %q' "${cmd[@]}"
printf '\n'

if [[ "$apply" -ne 1 ]]; then
  echo "[OK] Dry-run preview only. Re-run with --apply to execute sync."
  exit 0
fi

if "${cmd[@]}"; then
  echo "[OK] Sync completed"
else
  rc=$?
  echo "[ERROR] Sync failed with exit code $rc" >&2
  exit "$rc"
fi
