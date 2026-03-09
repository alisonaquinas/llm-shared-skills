# hexdump Installation and Setup

## Overview

hexdump is part of standard Unix utilities or development tools.

## Platform-Specific Installation

### macOS

hexdump is available via brew

```bash
which hexdump
brew install hexdump 2>/dev/null || echo "Check if built-in"
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y hexdump

# Or binutils if needed
apt-get install -y binutils
```

### Fedora / RHEL / CentOS

```bash
dnf install -y hexdump
```

### Arch Linux

```bash
pacman -S --noconfirm hexdump
```

### Alpine Linux

```bash
apk add --no-cache hexdump
```

## Verification

```bash
which hexdump
hexdump --version 2>/dev/null || hexdump --help | head -3
```

## Resources

- Manual: man hexdump
