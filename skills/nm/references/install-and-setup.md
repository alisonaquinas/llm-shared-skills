# nm Installation and Setup

## Overview

nm is part of standard Unix utilities or development tools.

## Platform-Specific Installation

### macOS

nm is available via brew

```bash
which nm
brew install nm 2>/dev/null || echo "Check if built-in"
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y nm

# Or binutils if needed
apt-get install -y binutils
```

### Fedora / RHEL / CentOS

```bash
dnf install -y nm
```

### Arch Linux

```bash
pacman -S --noconfirm nm
```

### Alpine Linux

```bash
apk add --no-cache nm
```

## Verification

```bash
which nm
nm --version 2>/dev/null || nm --help | head -3
```

## Resources

- Manual: man nm
