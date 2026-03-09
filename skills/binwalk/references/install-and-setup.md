# binwalk Installation and Setup

## Overview

binwalk is part of standard Unix utilities or development tools.

## Platform-Specific Installation

### macOS

binwalk is available via brew

```bash
which binwalk
brew install binwalk 2>/dev/null || echo "Check if built-in"
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y binwalk

# Or binutils if needed
apt-get install -y binutils
```

### Fedora / RHEL / CentOS

```bash
dnf install -y binwalk
```

### Arch Linux

```bash
pacman -S --noconfirm binwalk
```

### Alpine Linux

```bash
apk add --no-cache binwalk
```

## Verification

```bash
which binwalk
binwalk --version 2>/dev/null || binwalk --help | head -3
```

## Resources

- Manual: man binwalk
