#!/usr/bin/env bash
set -euo pipefail

json=false
if [[ "${1-}" == "--json" ]]; then
  json=true
  shift
fi

if (($# != 0)); then
  printf 'usage: %s [--json]\n' "$(basename "$0")" >&2
  exit 2
fi

json_escape() {
  sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e $'s/\t/\\t/g' -e $'s/\r/\\r/g' -e ':a;N;$!ba;s/\n/\\n/g'
}

json_string() {
  local value=$1
  printf '"%s"' "$(printf '%s' "$value" | json_escape)"
}

timestamp=$(date --iso-8601=seconds)
linux_path=$PWD
windows_path=missing
roundtrip_path=missing
if command -v wslpath >/dev/null 2>&1; then
  windows_path=$(wslpath -w "$linux_path")
  roundtrip_path=$(wslpath "$windows_path")
fi

tmpfile=$(mktemp)
trap 'rm -f "$tmpfile" "$tmpfile.stderr" "$tmpfile.crlf"' EXIT

cmd_stdout=''
cmd_stderr=''
cmd_exit=-1
if command -v cmd.exe >/dev/null 2>&1; then
  if cmd.exe /c "(echo stdout) & (echo stderr 1>&2)" >"$tmpfile" 2>"$tmpfile.stderr"; then
    cmd_exit=0
  else
    cmd_exit=$?
  fi
  cmd_stdout=$(tr -d '\r' <"$tmpfile")
  cmd_stderr=$(tr -d '\r' <"$tmpfile.stderr")
fi

exit_probe=missing
if command -v cmd.exe >/dev/null 2>&1; then
  if cmd.exe /c exit 7; then
    exit_probe=0
  else
    exit_probe=$?
  fi
fi

printf 'alpha\r\nbeta\r\n' >"$tmpfile.crlf"
if grep -q $'\r' "$tmpfile.crlf"; then
  crlf_detected=true
else
  crlf_detected=false
fi

if [[ "$json" == true ]]; then
  printf '{'
  printf '"timestamp":'; json_string "$timestamp"; printf ','
  printf '"linux_path":'; json_string "$linux_path"; printf ','
  printf '"windows_path":'; json_string "$windows_path"; printf ','
  printf '"roundtrip_path":'; json_string "$roundtrip_path"; printf ','
  printf '"cmd_stdout":'; json_string "$cmd_stdout"; printf ','
  printf '"cmd_stderr":'; json_string "$cmd_stderr"; printf ','
  printf '"cmd_exit":%s,' "$cmd_exit"
  if [[ "$exit_probe" == "missing" ]]; then
    printf '"exit_probe":"missing",'
  else
    printf '"exit_probe":%s,' "$exit_probe"
  fi
  printf '"crlf_detected":%s' "$crlf_detected"
  printf '}'
  exit 0
fi

printf 'timestamp=%s\n' "$timestamp"
printf 'linux_path=%s\n' "$linux_path"
printf 'windows_path=%s\n' "$windows_path"
printf 'roundtrip_path=%s\n' "$roundtrip_path"
printf 'cmd_stdout=%s\n' "$cmd_stdout"
printf 'cmd_stderr=%s\n' "$cmd_stderr"
printf 'cmd_exit=%s\n' "$cmd_exit"
printf 'exit_probe=%s\n' "$exit_probe"
printf 'crlf_detected=%s\n' "$crlf_detected"
