# objdump Installation and Setup

## Overview

objdump is part of standard Unix utilities or development tools.

## Platform-Specific Installation

### macOS

objdump is available via brew

```bash
which objdump
brew install objdump 2>/dev/null || echo "Check if built-in"
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y objdump

# Or binutils if needed
apt-get install -y binutils
```

### Fedora / RHEL / CentOS

```bash
dnf install -y objdump
```

### Arch Linux

```bash
pacman -S --noconfirm objdump
```

### Alpine Linux

```bash
apk add --no-cache objdump
```

## Verification

```bash
which objdump
objdump --version 2>/dev/null || objdump --help | head -3
```

## Resources

- Manual: man objdump
