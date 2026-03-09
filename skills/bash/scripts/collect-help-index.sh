#!/usr/bin/env bash
set -euo pipefail

json=false
if [[ "${1-}" == "--json" ]]; then
  json=true
  shift
fi

if (($# == 0)); then
  mapfile -t builtins < <(compgen -b | sort)
else
  builtins=("$@")
fi

json_escape() {
  sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e $'s/\t/\\t/g' -e $'s/\r/\\r/g' -e ':a;N;$!ba;s/\n/\\n/g'
}

json_string() {
  local value=$1
  printf '"%s"' "$(printf '%s' "$value" | json_escape)"
}

timestamp=$(date --iso-8601=seconds)
man_available=false
info_available=false
command -v man >/dev/null 2>&1 && man_available=true
command -v info >/dev/null 2>&1 && info_available=true

records=()
for name in "${builtins[@]}"; do
  if help "$name" >/dev/null 2>&1; then
    records+=("$name"$'\t'"true")
  else
    records+=("$name"$'\t'"false")
  fi
done

if [[ "$json" == true ]]; then
  printf '{'
  printf '"timestamp":'; json_string "$timestamp"; printf ','
  printf '"builtin_count":%s,' "${#builtins[@]}"
  printf '"man_available":%s,' "$man_available"
  printf '"info_available":%s,' "$info_available"
  printf '"builtins":['
  first=true
  for record in "${records[@]}"; do
    IFS=$'\t' read -r name status <<<"$record"
    [[ "$first" == true ]] && first=false || printf ','
    printf '{'
    printf '"name":'; json_string "$name"; printf ','
    printf '"help_available":%s' "$status"
    printf '}'
  done
  printf ']'
  printf '}'
  exit 0
fi

printf 'timestamp=%s\n' "$timestamp"
printf 'builtin_count=%s\n' "${#builtins[@]}"
printf 'man_available=%s\n' "$man_available"
printf 'info_available=%s\n' "$info_available"
for record in "${records[@]}"; do
  IFS=$'\t' read -r name status <<<"$record"
  printf 'builtin %s help_available=%s\n' "$name" "$status"
done
