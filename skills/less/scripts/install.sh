#!/usr/bin/env bash
set -euo pipefail

detect_platform() {
  local system=$(uname -s)
  [[ "$system" == "Darwin" ]] && echo "macos" && return
  [[ "$system" == "Linux" ]] && [[ -f /etc/os-release ]] && source /etc/os-release && echo "${ID:-linux}" && return
  echo "unknown"
}

main() {
  command -v less >/dev/null && echo "[OK] less is available" && return 0
  
  local platform=$(detect_platform)
  case "$platform" in
    macos) brew install less 2>/dev/null && echo "[OK] less installed" ;;
    debian|ubuntu) apt-get update && apt-get install -y less && echo "[OK] less installed" ;;
    fedora|rhel|centos) dnf install -y less && echo "[OK] less installed" ;;
    arch) pacman -S --noconfirm less && echo "[OK] less installed" ;;
    alpine) apk add --no-cache less && echo "[OK] less installed" ;;
    *) echo "[ERROR] Unsupported: $platform"; exit 1 ;;
  esac
}

main "$@"
