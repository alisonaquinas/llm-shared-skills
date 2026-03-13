#!/usr/bin/env bash
# Install xmllint (part of libxml2-utils / libxml2)

set -euo pipefail

if command -v xmllint &>/dev/null; then
  echo "[OK] xmllint already available: $(xmllint --version 2>&1 | head -1)"
  exit 0
fi

if command -v apt-get &>/dev/null; then
  apt-get update && apt-get install -y libxml2-utils
elif command -v brew &>/dev/null; then
  brew install libxml2
elif command -v dnf &>/dev/null; then
  dnf install -y libxml2
elif command -v pacman &>/dev/null; then
  pacman -S --noconfirm libxml2
elif command -v apk &>/dev/null; then
  apk add --no-cache libxml2-utils
else
  echo "No supported package manager found. Install libxml2-utils manually." >&2
  exit 1
fi

echo "[OK] Installed: $(xmllint --version 2>&1 | head -1)"
