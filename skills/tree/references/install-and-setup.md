# tree Installation and Setup

## Overview

tree is available on most platforms.

## Platform-Specific Installation

### macOS

```bash
brew install tree
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y tree
```

### Fedora / RHEL / CentOS

```bash
dnf install -y tree
```

### Arch Linux

```bash
pacman -S tree
```

### Alpine Linux

```bash
apk add --no-cache tree
```

## Verification

```bash
which tree
tree --version 2>/dev/null || tree --help | head -3
```

## Resources

- Manual: man tree
