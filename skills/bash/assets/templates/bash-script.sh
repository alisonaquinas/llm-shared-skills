#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: bash-script.sh [-h] -i INPUT [-o OUTPUT]
EOF
}

cleanup() {
  :
}

trap cleanup EXIT

input=''
output=''

while getopts ':hi:o:' opt; do
  case "$opt" in
    h)
      usage
      exit 0
      ;;
    i)
      input=$OPTARG
      ;;
    o)
      output=$OPTARG
      ;;
    :)
      printf 'missing value for -%s\n' "$OPTARG" >&2
      exit 2
      ;;
    \?)
      printf 'unknown option: -%s\n' "$OPTARG" >&2
      exit 2
      ;;
  esac
done
shift "$((OPTIND - 1))"

main() {
  printf 'input=%s\n' "$input"
  printf 'output=%s\n' "$output"
}

main "$@"
