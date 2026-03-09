#!/usr/bin/env bash
set -euo pipefail

DEFAULT_CONFIGS=(
  "./curvecapture/markdownlint-cli2.jsonc"
  "./markdownlint-cli2.jsonc"
  "./.markdownlint-cli2.jsonc"
)
USE_FIX=false
CONFIG_FILE=""

usage() {
  cat <<'USAGE'
Usage:
  run-markdownlint-cli2.sh [--fix] [--config <path>] [targets...]

Options:
  --fix             Apply markdownlint-cli2 auto-fixes.
  --config <path>   Use an explicit markdownlint-cli2 config file.
  -h, --help        Show this help.

Targets:
  File paths, directories, or globs. If omitted, defaults to:
  "**/*.md" "**/*.markdown"
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --fix)
      USE_FIX=true
      shift
      ;;
    --config)
      if [[ $# -lt 2 ]]; then
        echo "Error: --config requires a path" >&2
        exit 2
      fi
      CONFIG_FILE="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --)
      shift
      break
      ;;
    *)
      break
      ;;
  esac
done

TARGETS=("$@")
if [[ ${#TARGETS[@]} -eq 0 ]]; then
  TARGETS=("**/*.md" "**/*.markdown")
fi

if [[ -n "$CONFIG_FILE" ]]; then
  if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Error: config file not found: $CONFIG_FILE" >&2
    exit 2
  fi
else
  for candidate in "${DEFAULT_CONFIGS[@]}"; do
    if [[ -f "$candidate" ]]; then
      CONFIG_FILE="$candidate"
      break
    fi
  done
fi

if command -v markdownlint-cli2 >/dev/null 2>&1; then
  RUNNER=(markdownlint-cli2)
  RUNNER_KIND="cli2"
elif [[ -x "./node_modules/.bin/markdownlint-cli2" ]]; then
  RUNNER=(./node_modules/.bin/markdownlint-cli2)
  RUNNER_KIND="cli2"
elif command -v markdownlint >/dev/null 2>&1; then
  # Compatible fallback when markdownlint-cli2 is not installed.
  RUNNER=(markdownlint)
  RUNNER_KIND="markdownlint"
elif command -v npx >/dev/null 2>&1; then
  RUNNER=(npx --yes markdownlint-cli2)
  RUNNER_KIND="cli2"
else
  echo "Error: markdownlint-cli2, markdownlint, and npx are unavailable" >&2
  exit 127
fi

CMD=("${RUNNER[@]}")
if [[ -n "$CONFIG_FILE" ]]; then
  CMD+=(--config "$CONFIG_FILE")
fi
if [[ "$RUNNER_KIND" == "markdownlint" ]]; then
  # Map markdownlint-cli2 disabled rules from curvecapture config:
  # line-length -> MD013, no-trailing-punctuation -> MD026, no-inline-html -> MD033
  CMD+=(--disable MD013 MD026 MD033)
  # markdownlint expects a separator before file args when using variadic --disable.
  CMD+=(--)
fi
if [[ "$USE_FIX" == true ]]; then
  CMD+=(--fix)
fi
CMD+=("${TARGETS[@]}")

echo "markdownlint-cli2 config: ${CONFIG_FILE:-<none>}"
echo "markdownlint-cli2 targets: ${TARGETS[*]}"
"${CMD[@]}"
