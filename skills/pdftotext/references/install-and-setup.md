# pdftotext Installation and Setup

## Overview

pdftotext is a specialized utility for document and metadata handling.

## Platform-Specific Installation

### macOS

```bash
brew install pdftotext
```

### Debian / Ubuntu

```bash
apt-get update
apt-get install -y pdftotext
```

### Fedora / RHEL / CentOS

```bash
dnf install -y pdftotext
```

### Arch Linux

```bash
pacman -S pdftotext
```

### Alpine Linux

```bash
apk add --no-cache pdftotext
```

## Verification

```bash
which pdftotext
pdftotext --version 2>/dev/null || pdftotext --help | head -3
```

## Resources

- Manual: man pdftotext
