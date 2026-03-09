#!/usr/bin/env bash

log_info() {
  printf '[info]  %s\n' "$*"
}

log_warn() {
  printf '[warn]  %s\n' "$*" >&2
}

log_error() {
  printf '[error] %s\n' "$*" >&2
}

die() {
  local msg=${1:-'fatal error'}
  local code=${2:-1}
  log_error "$msg"
  exit "$code"
}

require_command() {
  (( $# >= 1 )) || { log_error "require_command: missing argument"; return 2; }
  local name=$1
  command -v "$name" >/dev/null 2>&1 || {
    log_error "missing required command: $name"
    return 127
  }
}
