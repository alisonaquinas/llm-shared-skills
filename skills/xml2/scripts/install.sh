#!/usr/bin/env bash
# Install xml2 and 2xml

set -euo pipefail

if command -v apt-get &>/dev/null; then
  apt-get update && apt-get install -y xml2
elif command -v brew &>/dev/null; then
  brew install xml2
elif command -v dnf &>/dev/null; then
  dnf install -y xml2
elif command -v pacman &>/dev/null; then
  pacman -S --noconfirm xml2
elif command -v apk &>/dev/null; then
  apk add --no-cache xml2
else
  echo "No supported package manager found. Install xml2 manually." >&2
  exit 1
fi

echo "Installed: $(which xml2) and $(which 2xml)"
