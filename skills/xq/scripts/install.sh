#!/usr/bin/env bash
# Install jq and xq (via yq Python package)

set -euo pipefail

# Install jq
if command -v apt-get &>/dev/null; then
  apt-get update && apt-get install -y jq
elif command -v brew &>/dev/null; then
  brew install jq
elif command -v dnf &>/dev/null; then
  dnf install -y jq
elif command -v pacman &>/dev/null; then
  pacman -S --noconfirm jq
elif command -v apk &>/dev/null; then
  apk add --no-cache jq
else
  echo "No supported package manager found. Install jq manually from https://jqlang.org/" >&2
  exit 1
fi

# Install yq (provides xq)
if command -v pip3 &>/dev/null; then
  pip3 install yq
elif command -v pip &>/dev/null; then
  pip install yq
else
  echo "pip not found. Install Python and pip, then run: pip install yq" >&2
  exit 1
fi

echo "Installed:"
echo "  jq:  $(jq --version)"
echo "  xq:  $(xq --version 2>&1 | head -1)"
