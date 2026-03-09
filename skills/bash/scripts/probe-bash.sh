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

json_array_from_lines() {
  local first=true line
  printf '['
  while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    if [[ "$first" == true ]]; then
      first=false
    else
      printf ','
    fi
    json_string "$line"
  done
  printf ']'
}

timestamp=$(date --iso-8601=seconds)
home_dir=${HOME:-}
shell_path=${SHELL:-}
cwd=$PWD
bash_version=${BASH_VERSION:-unknown}
os_release=$(uname -r)

if grep -qiE 'microsoft|wsl' /proc/sys/kernel/osrelease 2>/dev/null; then
  is_wsl=true
else
  is_wsl=false
fi

startup_files=(
  /etc/profile
  "$home_dir/.bash_profile"
  "$home_dir/.bash_login"
  "$home_dir/.profile"
  "$home_dir/.bashrc"
  "$home_dir/.bash_logout"
)

enabled_set_options=$(set -o | awk '$2 == "on" { print $1 }')
selected_shopt=$(shopt -p extglob nullglob dotglob failglob globstar checkwinsize expand_aliases 2>/dev/null || true)
available_tools=$(for name in bash help man info wslpath sed awk grep find xargs shellcheck dos2unix; do
  if command -v "$name" >/dev/null 2>&1; then
    printf '%s=%s\n' "$name" "$(command -v "$name")"
  else
    printf '%s=missing\n' "$name"
  fi
done)

if [[ "$json" == true ]]; then
  printf '{'
  printf '"timestamp":'; json_string "$timestamp"; printf ','
  printf '"bash_version":'; json_string "$bash_version"; printf ','
  printf '"shell":'; json_string "$shell_path"; printf ','
  printf '"cwd":'; json_string "$cwd"; printf ','
  printf '"home":'; json_string "$home_dir"; printf ','
  printf '"os_release":'; json_string "$os_release"; printf ','
  printf '"is_wsl":%s,' "$is_wsl"
  printf '"startup_files":['
  first=true
  for path in "${startup_files[@]}"; do
    [[ "$first" == true ]] && first=false || printf ','
    printf '{'
    printf '"path":'; json_string "$path"; printf ','
    if [[ -e "$path" ]]; then
      printf '"exists":true'
    else
      printf '"exists":false'
    fi
    printf '}'
  done
  printf '],'
  printf '"enabled_set_options":'
  printf '%s' "$enabled_set_options" | json_array_from_lines
  printf ','
  printf '"selected_shopt":'
  printf '%s' "$selected_shopt" | json_array_from_lines
  printf ','
  printf '"available_tools":'
  printf '%s' "$available_tools" | json_array_from_lines
  printf '}'
  exit 0
fi

printf 'timestamp=%s\n' "$timestamp"
printf 'bash_version=%s\n' "$bash_version"
printf 'shell=%s\n' "$shell_path"
printf 'cwd=%s\n' "$cwd"
printf 'home=%s\n' "$home_dir"
printf 'os_release=%s\n' "$os_release"
printf 'is_wsl=%s\n' "$is_wsl"
printf 'startup_files:\n'
for path in "${startup_files[@]}"; do
  if [[ -e "$path" ]]; then
    printf '  present %s\n' "$path"
  else
    printf '  missing %s\n' "$path"
  fi
done
printf 'enabled_set_options:\n%s\n' "$enabled_set_options"
printf 'selected_shopt:\n%s\n' "$selected_shopt"
printf 'available_tools:\n%s\n' "$available_tools"
