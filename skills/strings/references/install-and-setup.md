# strings Installation and Setup

## Overview

strings is part of standard Unix utilities or development tools.

## Platform-Specific Installation

### macOS

strings is available via brew

```bash
which strings
brew install strings 2>/dev/null || echo "Check if built-in"
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y strings

# Or binutils if needed
apt-get install -y binutils
```

### Fedora / RHEL / CentOS

```bash
dnf install -y strings
```

### Arch Linux

```bash
pacman -S --noconfirm strings
```

### Alpine Linux

```bash
apk add --no-cache strings
```

## Verification

```bash
which strings
strings --version 2>/dev/null || strings --help | head -3
```

## Resources

- Manual: man strings
