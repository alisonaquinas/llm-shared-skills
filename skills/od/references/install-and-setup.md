# od Installation and Setup

## Overview

od is part of standard Unix utilities or development tools.

## Platform-Specific Installation

### macOS

od is available via brew

```bash
which od
brew install od 2>/dev/null || echo "Check if built-in"
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y od

# Or binutils if needed
apt-get install -y binutils
```

### Fedora / RHEL / CentOS

```bash
dnf install -y od
```

### Arch Linux

```bash
pacman -S --noconfirm od
```

### Alpine Linux

```bash
apk add --no-cache od
```

## Verification

```bash
which od
od --version 2>/dev/null || od --help | head -3
```

## Resources

- Manual: man od
