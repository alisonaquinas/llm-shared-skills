# xxd Installation and Setup

## Overview

xxd is part of standard Unix utilities or development tools.

## Platform-Specific Installation

### macOS

xxd is available via brew

```bash
which xxd
brew install xxd 2>/dev/null || echo "Check if built-in"
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y xxd

# Or binutils if needed
apt-get install -y binutils
```

### Fedora / RHEL / CentOS

```bash
dnf install -y xxd
```

### Arch Linux

```bash
pacman -S --noconfirm xxd
```

### Alpine Linux

```bash
apk add --no-cache xxd
```

## Verification

```bash
which xxd
xxd --version 2>/dev/null || xxd --help | head -3
```

## Resources

- Manual: man xxd
