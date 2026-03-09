# tail Installation and Setup

## Variants

### GNU tail (coreutils)

- Full-featured implementation with GNU extensions
- Supports `-f` (follow) and `-F` (follow with rotation)
- Default on Linux (most distributions)
- Available on macOS via Homebrew as part of coreutils

### BSD tail

- Simpler feature set, POSIX-like
- Default on macOS (built-in)
- Supports `-f` (follow) but behavior may differ from GNU
- Supports `-F` (follow with rotation restart)

### POSIX tail

- Minimal interface (required for portable scripts)
- Supported by both GNU and BSD

## Platform-Specific Installation

### macOS

#### Check Current Installation

```bash
# macOS has BSD tail built-in
tail --version
# Output: "tail: illegal option -- -"  (BSD tail doesn't recognize --version)

# Check which tail is available
which tail
# Output: /usr/bin/tail (BSD version)
```

#### Install GNU tail (via coreutils)

```bash
# Via Homebrew (recommended)
brew install coreutils

# This installs all GNU core utilities
tail --version  # Now points to GNU tail
```

### Debian / Ubuntu

```bash
# tail is typically pre-installed (GNU coreutils)
apt-get update
apt-get install -y coreutils

# Verify
tail --version
```

### Fedora / RHEL / CentOS

```bash
# tail is typically pre-installed (GNU coreutils)
dnf install -y coreutils

# Verify
tail --version
```

### Arch Linux

```bash
# tail is typically pre-installed (GNU coreutils)
pacman -S --noconfirm coreutils

# Verify
tail --version
```

### Alpine Linux

```bash
# tail is in coreutils package
apk add --no-cache coreutils

# Verify
tail --version
```

## Verification

### Check Installation

```bash
# Verify tail is available
which tail
tail --version

# Test with sample
tail -n 5 /etc/passwd
```

### Identify Variant

```bash
# GNU tail (will work)
tail --version

# BSD tail (will show error about illegal option)
# But these still work on BSD:
tail -n 5 file.txt
tail -f logfile
```

## Post-Install Configuration

### Shell Integration (Optional)

Most users won't need to configure anything beyond installation.

### Manual Path Setup

```bash
# If installing from source or custom location
export PATH="/custom/bin:$PATH"
tail --version
```

## Testing Installation

### Test with Real Data

```bash
# Create test file
cat > /tmp/test_tail.txt << 'EOF'
line 1
line 2
line 3
line 4
line 5
EOF

# Test line extraction
tail -n 3 /tmp/test_tail.txt

# Test byte extraction
tail -c 20 /tmp/test_tail.txt

# Test follow mode (run in background, then append)
tail -f /tmp/test_tail.txt &
sleep 1
echo "new line" >> /tmp/test_tail.txt
kill %1
```

## Resources

- `man tail` — Full manual and options
- GNU Coreutils: <https://www.gnu.org/software/coreutils/manual/html_node/tail-invocation.html>
- BSD tail: <https://www.freebsd.org/cgi/man.cgi?query=tail>
