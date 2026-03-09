# exiftool Installation and Setup

## Overview

exiftool is a specialized utility for document and metadata handling.

## Platform-Specific Installation

### macOS

```bash
brew install exiftool
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y exiftool
```

### Fedora / RHEL / CentOS

```bash
dnf install -y exiftool
```

### Arch Linux

```bash
pacman -S exiftool
```

### Alpine Linux

```bash
apk add --no-cache exiftool
```

## Verification

```bash
which exiftool
exiftool --version 2>/dev/null || exiftool --help | head -3
```

## Resources

- Manual: man exiftool
