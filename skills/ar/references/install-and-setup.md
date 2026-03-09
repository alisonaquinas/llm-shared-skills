# ar Installation and Setup

## Overview

ar is part of GNU binutils and comes built-in on most Unix systems. It's used for creating and managing static library archives.

## Platform-Specific Installation

### macOS

ar is built-in. No installation needed.

```bash
# Verify
ar --version
which ar
# Output: /usr/bin/ar
```

### Debian / Ubuntu

```bash
# ar is typically pre-installed (part of binutils)
apt-get update
apt-get install -y binutils

# Verify
ar --version
```

### Fedora / RHEL / CentOS

```bash
# ar is typically pre-installed
dnf install -y binutils

# Verify
ar --version
```

### Arch Linux

```bash
# ar is in binutils package
pacman -S --noconfirm binutils

# Verify
ar --version
```

### Alpine Linux

```bash
# ar is in binutils package
apk add --no-cache binutils

# Verify
ar --version
```

### Windows

#### MinGW / MSYS2

```bash
pacman -S mingw-w64-x86_64-binutils
```

#### WSL2

Use Linux installation for your distribution.

## Verification

### Check Installation

```bash
# Verify ar is available
which ar

# Check version
ar --version

# Test with sample
ar t /usr/lib/libc.a 2>/dev/null || echo "ar is working"
```

## Post-Install Configuration

ar requires no configuration. It works out of the box.

## Testing Installation

### Create and Manage Test Archive

```bash
# Create test object files
cat > test1.c << 'EOF'
int func1() { return 1; }
EOF

cat > test2.c << 'EOF'
int func2() { return 2; }
EOF

# Compile to object files
gcc -c test1.c -o test1.o
gcc -c test2.c -o test2.o

# Create archive
ar rcs libtest.a test1.o test2.o

# List contents
ar t libtest.a
# Output: test1.o
#         test2.o

# Display symbol table
nm libtest.a

# Cleanup
rm -f *.o *.c libtest.a
```

## Resources

- ar Manual: <https://sourceware.org/binutils/docs/binutils/ar.html>
- GNU Binutils: <https://www.gnu.org/software/binutils/>
