#!/usr/bin/env bash
set -euo pipefail

detect_platform() {
  local system=$(uname -s)
  [[ "$system" == "Darwin" ]] && echo "macos" && return
  [[ "$system" == "Linux" ]] && [[ -f /etc/os-release ]] && source /etc/os-release && echo "${ID:-linux}" && return
  echo "unknown"
}

main() {
  command -v pdftotext >/dev/null && echo "[OK] pdftotext is available" && return 0
  
  local platform=$(detect_platform)
  case "$platform" in
    macos) brew install pdftotext 2>/dev/null && echo "[OK] pdftotext installed" || echo "[HINT] Install Homebrew" ;;
    debian|ubuntu) apt-get update && apt-get install -y pdftotext && echo "[OK] pdftotext installed" ;;
    fedora|rhel|centos) dnf install -y pdftotext && echo "[OK] pdftotext installed" ;;
    arch) pacman -S --noconfirm pdftotext && echo "[OK] pdftotext installed" ;;
    alpine) apk add --no-cache pdftotext && echo "[OK] pdftotext installed" ;;
    *) echo "[ERROR] Unsupported platform: $platform"; exit 1 ;;
  esac
}

main "$@"
