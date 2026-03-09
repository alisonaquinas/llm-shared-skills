#!/usr/bin/env bash
set -euo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
source "$script_dir/lib/sample.sh"

main() {
  require_command printf
  log_info "Hello from Bash library skeleton"
}

main "$@"
