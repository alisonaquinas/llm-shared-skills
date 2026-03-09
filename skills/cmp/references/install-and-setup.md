# cmp Installation and Setup

## Overview

cmp is part of standard Unix utilities or development tools.

## Platform-Specific Installation

### macOS

cmp is built-in

```bash
which cmp
brew install cmp 2>/dev/null || echo "Check if built-in"
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y cmp

# Or binutils if needed
apt-get install -y binutils
```

### Fedora / RHEL / CentOS

```bash
dnf install -y cmp
```

### Arch Linux

```bash
pacman -S --noconfirm cmp
```

### Alpine Linux

```bash
apk add --no-cache cmp
```

## Verification

```bash
which cmp
cmp --version 2>/dev/null || cmp --help | head -3
```

## Resources

- Manual: man cmp
