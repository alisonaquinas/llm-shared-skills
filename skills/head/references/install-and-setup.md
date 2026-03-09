# head Installation and Setup

## Variants

### GNU head (coreutils)

- Full-featured implementation with GNU extensions
- Default on Linux (most distributions)
- Available on macOS via Homebrew as `ghead`

### BSD head

- Default on macOS (built-in)
- Simpler feature set
- Used on BSD systems

### POSIX head

- Minimal interface (required for portable scripts)
- Supported by both GNU and BSD

## Platform-Specific Installation

### macOS

#### Check Current Installation

```bash
# macOS has BSD head built-in
head --version
# Output: "head: illegal option -- -"  (BSD head doesn't recognize --version)

# Check which head is available
which head
# Output: /usr/bin/head (BSD version)
```

#### Install GNU head (ghead)

```bash
# Via Homebrew (recommended)
brew install coreutils

# This installs all GNU core utilities with 'g' prefix
ghead --version  # GNU head is now available as 'ghead'
head -n 5 file.txt  # BSD head still available as 'head'
```

### Debian / Ubuntu

```bash
# head is typically pre-installed (GNU coreutils)
apt-get update
apt-get install -y coreutils

# Verify
head --version
```

### Fedora / RHEL / CentOS

```bash
# head is typically pre-installed (GNU coreutils)
dnf install -y coreutils

# Verify
head --version
```

### Arch Linux

```bash
# head is typically pre-installed (GNU coreutils)
pacman -S --noconfirm coreutils

# Verify
head --version
```

### Alpine Linux

```bash
# head is in coreutils package
apk add --no-cache coreutils

# Verify
head --version
```

### Windows (WSL2 / Git Bash / Cygwin)

#### WSL2 (Ubuntu / Debian)

```bash
wsl
apt-get update
apt-get install -y coreutils
head --version
```

#### Git Bash

```bash
# Git Bash includes GNU head by default
head --version
```

#### Cygwin

```bash
# Use Cygwin setup or apt-cyg
apt-cyg install coreutils

# Verify
head --version
```

#### Chocolatey

```powershell
choco install -y coreutils
head --version
```

## Verification

### Check Installation

```bash
# Verify head is available
which head
head --version

# Test with sample
echo -e "line1\nline2\nline3\nline4\nline5" | head -n 3
```

### Identify Variant

```bash
# GNU head (will work)
head --version

# BSD head (will show error about illegal option)
# But these still work on BSD:
head -n 5 file.txt
head -c 1024 file.bin
```

## Minimum Version Notes

### GNU Coreutils

- Head is part of GNU Coreutils since early versions
- All modern versions support required flags
- No specific minimum version needed for common usage

### BSD head (Availability)

- Available on all macOS and BSD systems
- All versions support basic options (`-n`, `-c`)
- GNU extensions (like `-n -5`) are not available

## Post-Install Configuration

### Shell Integration (Optional)

If you've installed `ghead` on macOS and want to use it as the default:

```bash
# Add to ~/.zshrc or ~/.bash_profile
alias head=ghead
```

Or use in PATH ordering:

```bash
# Add GNU bin directory first in PATH
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
```

### Manual Path Setup

```bash
# If installing from source or custom location
export PATH="/custom/bin:$PATH"
head --version
```

## Testing Installation

### Test with Real Data

```bash
# Create test file
cat > /tmp/test_head.txt << 'EOF'
header line 1
data line 2
data line 3
data line 4
data line 5
EOF

# Test line extraction
head -n 3 /tmp/test_head.txt

# Test byte extraction
head -c 20 /tmp/test_head.txt

# Test with multiple files
head -n 1 /tmp/test_head.txt /tmp/test_head.txt
```

### Validate Flags

```bash
# Test explicit line count (required for portable scripts)
head -n 5 /tmp/test_head.txt

# Test explicit byte count
head -c 100 /tmp/test_head.txt

# Test quiet mode (suppress file headers on multiple files)
head -q -n 2 /tmp/test_head.txt /tmp/test_head.txt

# Test verbose mode (force file headers)
head -v -n 2 /tmp/test_head.txt
```

## Troubleshooting Installation

### Command Not Found

```bash
# Ensure coreutils/head is installed
apt-get install -y coreutils  # Linux
brew install coreutils        # macOS

# Verify PATH
echo $PATH
which head
```

### Version Output Not Recognized

```bash
# You have BSD head (doesn't recognize --version)
# This is normal on macOS

# Run without --version flag
head -n 1 /etc/passwd
```

### Permission Denied

```bash
# Check permissions
ls -l /usr/bin/head
which head

# Reinstall to fix permissions
apt-get install --reinstall coreutils
```

## Building from Source (Advanced)

If binaries aren't available for your platform:

```bash
# Download GNU Coreutils
cd /tmp
wget https://ftp.gnu.org/gnu/coreutils/coreutils-9.1.tar.xz
tar -xf coreutils-9.1.tar.xz
cd coreutils-9.1

# Configure and build
./configure --prefix=/usr/local
make
sudo make install

# Verify
/usr/local/bin/head --version
```

## Resources

- `man head` — Full manual and options
- GNU Coreutils: <https://www.gnu.org/software/coreutils/manual/html_node/head-invocation.html>
- BSD head: <https://www.freebsd.org/cgi/man.cgi?query=head>
