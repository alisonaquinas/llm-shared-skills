# xmllint Installation and Setup

## Overview

xmllint is a specialized utility for document and metadata handling.

## Platform-Specific Installation

### macOS

```bash
brew install xmllint
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y xmllint
```

### Fedora / RHEL / CentOS

```bash
dnf install -y xmllint
```

### Arch Linux

```bash
pacman -S xmllint
```

### Alpine Linux

```bash
apk add --no-cache xmllint
```

## Verification

```bash
which xmllint
xmllint --version 2>/dev/null || xmllint --help | head -3
```

## Resources

- Manual: man xmllint
