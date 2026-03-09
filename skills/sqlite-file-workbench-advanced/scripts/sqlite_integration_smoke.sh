#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  sqlite_integration_smoke.sh --db <file> [--python] [--node]

Options:
  --db <file>   Database file path
  --python      Run Python smoke check
  --node        Run Node smoke check
  -h, --help    Show this help

Behavior:
  If neither --python nor --node is provided, run both checks.
USAGE
}

run_python=0
run_node=0
explicit_flags=0
db_path=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --db)
      [[ $# -ge 2 ]] || { echo "[ERROR] --db needs a value" >&2; usage; exit 1; }
      db_path="$2"
      shift 2
      ;;
    --python)
      run_python=1
      explicit_flags=1
      shift
      ;;
    --node)
      run_node=1
      explicit_flags=1
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

[[ -n "$db_path" ]] || { echo "[ERROR] --db is required" >&2; usage; exit 1; }
[[ -f "$db_path" ]] || { echo "[ERROR] Database file not found: $db_path" >&2; exit 1; }

if [[ "$explicit_flags" -eq 0 ]]; then
  run_python=1
  run_node=1
fi

status=0
ran=0
skipped=0

run_python_check() {
  if ! command -v python3 >/dev/null 2>&1; then
    echo "[SKIP] python3 not found on PATH"
    skipped=$((skipped + 1))
    return 0
  fi

  local output
  if output="$(python3 - "$db_path" <<'PY'
import sqlite3
import sys

db = sys.argv[1]
conn = sqlite3.connect(f"file:{db}?mode=ro", uri=True)
cur = conn.cursor()
row = cur.execute("SELECT 1").fetchone()[0]
tables = cur.execute("SELECT count(*) FROM sqlite_master WHERE type='table'").fetchone()[0]
conn.close()
print(f"PYTHON_OK row={row} tables={tables}")
PY
)"; then
    echo "[OK] $output"
    ran=$((ran + 1))
    return 0
  else
    echo "[ERROR] Python smoke check failed" >&2
    status=1
    ran=$((ran + 1))
    return 1
  fi
}

run_node_check() {
  if ! command -v node >/dev/null 2>&1; then
    echo "[SKIP] node not found on PATH"
    skipped=$((skipped + 1))
    return 0
  fi

  local output
  if output="$(node -e '
const fs = require("node:fs");
const cp = require("node:child_process");
const db = process.argv[1];
if (!db || !fs.existsSync(db)) {
  console.error("database file not found");
  process.exit(2);
}
let usedBuiltin = false;
try {
  const sqlite = require("node:sqlite");
  const DatabaseSync = sqlite.DatabaseSync;
  if (!DatabaseSync) {
    throw new Error("node:sqlite DatabaseSync not available");
  }
  const conn = new DatabaseSync(db, { readOnly: true });
  const row = conn.prepare("SELECT 1 AS ok").get();
  const tableRow = conn.prepare("SELECT count(*) AS n FROM sqlite_master WHERE type=\"table\"").get();
  conn.close();
  console.log(`NODE_OK builtin row=${row.ok} tables=${tableRow.n}`);
  usedBuiltin = true;
} catch (err) {
  const res = cp.spawnSync("sqlite3", ["-readonly", db, "SELECT 1;"], { encoding: "utf8" });
  if (res.error) {
    console.error(`sqlite3 fallback failed: ${res.error.message}`);
    process.exit(3);
  }
  if (res.status !== 0) {
    console.error(res.stderr || "sqlite3 fallback returned non-zero status");
    process.exit(res.status || 4);
  }
  const val = (res.stdout || "").trim();
  console.log(`NODE_OK cli-fallback result=${val}`);
}
' -- "$db_path" 2>&1)"; then
    echo "[OK] $output"
    ran=$((ran + 1))
    return 0
  else
    echo "[ERROR] Node smoke check failed" >&2
    echo "$output" >&2
    status=1
    ran=$((ran + 1))
    return 1
  fi
}

if [[ "$run_python" -eq 1 ]]; then
  run_python_check || true
fi

if [[ "$run_node" -eq 1 ]]; then
  run_node_check || true
fi

echo "[INFO] checks_ran=$ran checks_skipped=$skipped"

if [[ "$status" -eq 0 ]]; then
  echo "[OK] Integration smoke checks passed"
else
  echo "[ERROR] Integration smoke checks failed" >&2
fi

exit "$status"
